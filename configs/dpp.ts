import type { ContextBuilder, ExtOptions, Plugin } from "@shougo/dpp-vim/types";
import {
	BaseConfig,
	type ConfigReturn,
	type MultipleHook,
} from "@shougo/dpp-vim/config";

import { Protocol } from "@shougo/dpp-vim/protocol";
import { mergeFtplugins } from "@shougo/dpp-vim/utils";

import type {
	Ext as TomlExt,
	Params as TomlParams,
} from "@shougo/dpp-ext-toml";

import type {
	Ext as LazyExt,
	LazyMakeStateResult,
	Params as LazyParams,
} from "@shougo/dpp-ext-lazy";

import type { Denops } from "@denops/std";
import * as fn from "@denops/std/function";

import { expandGlob } from "@std/fs/expand-glob";

export class Config extends BaseConfig {
	override async config(args: {
		denops: Denops;
		contextBuilder: ContextBuilder;
		basePath: string;
	}): Promise<ConfigReturn> {
		//
		// const vimrcs = [];
		//
		// args.contextBuilder.setGlobal({
		// 	vimrcs,
		// 	extParams: {
		// 		installer: {
		// 			checkDiff: true,
		// 			logFilePath: "~/.neovim_cache/dpp/installer-log.txt",
		// 			githubAPIToken: Deno.env.get("GITHUB_API_TOKEN"),
		// 		},
		// 	},
		// 	protocols: [
		// 		"git",
		// 		"http"
		// 	],
		// });

		const [context, options] = await args.contextBuilder.get(args.denops);
		const protocols = await args.denops.dispatcher.getProtocols() as Record<string, Protocol>;

		const recordPlugins: Record<string, Plugin> = {};
		const ftplugins: Record<string, string> = {};
		const hooksFiles: string[] = [];
		let multipleHooks: MultipleHook[] = [];

		const [tomlExt, tomlOptions, tomlParams]:
			[
				TomlExt | undefined,
				ExtOptions,
				TomlParams,
			] = await args.denops.dispatcher.getExt(
				"toml",
			) as [TomlExt | undefined, ExtOptions, TomlParams];
		if (tomlExt) {
			const action = tomlExt.actions.load;
			const tomlPromises = [
				{ path: "$BASE_DIR/dpp.toml", lazy: false },
			].map((tomlFile) => action.callback({
				denops: args.denops,
				context,
				options,
				protocols,
				extOptions: tomlOptions,
				extParams: tomlParams,
				actionParams: {
					path: tomlFile.path,
					options: {
						lazy: tomlFile.lazy,
					},
				},
			}));

			const tomls = await Promise.all(tomlPromises);
			// Merge toml results
			for (const toml of tomls) {
				for (const plugin of toml.plugins ?? []) {
					recordPlugins[plugin.name] = plugin;
				}

				if (toml.ftplugins) {
					mergeFtplugins(ftplugins, toml.ftplugins)
				}

				if (toml.multiple_hooks) {
					multipleHooks = [...multipleHooks, ...toml.multiple_hooks];
				}

				if (toml.hooks_file) {
					hooksFiles.push(toml.hooks_file);
				}
			}
		}

		const [lazyExt, lazyOptions, lazyParams]: [
			LazyExt | undefined,
			ExtOptions,
			LazyParams,
		] = await args.denops.dispatcher.getExt(
			"lazy",
		) as [LazyExt | undefined, ExtOptions, LazyParams];
		let lazyResult: LazyMakeStateResult | undefined = undefined;

		if (lazyExt) {
			const action = lazyExt.actions.makeState;

			lazyResult = await action.callback({
				denops: args.denops,
				context,
				options,
				protocols,
				extOptions: lazyOptions,
				extParams: lazyParams,
				actionParams: {
					plugins: Object.values(recordPlugins),
				},
			});
		}
		const checkFiles = [];
		for await (const file of expandGlob('${Deno.env.get("BASE_DIR")}/*')) {
			checkFiles.push(file.path);
		}

		const groups = {
			ddc: {
				on_source: "ddc.vim",
			},
			ddu: {
				on_source: "ddu.vim",
			},
		};

		return {
			checkFiles,
			ftplugins,
			hooksFiles,
			multipleHooks,
			groups,
			plugins: lazyResult?.plugins ?? [],
			stateLines: lazyResult?.stateLines ?? [],
		};

	}
}
