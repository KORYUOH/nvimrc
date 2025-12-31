import { BaseConfig , ConfigArguments } from "@shougo/ddc-vim/config";
import type { Context , DdcItem } from "@shougo/ddc-vim/type";

import type { Denops } from "@denops/std";

import * as fn from "@denops/std/function";

export class Config extends BaseConfig
{
	override async condig( args: ConfigArguments ) : Promise<void> 
	{
		const commonSources = [ 
			"arround",
			"file",
			"register",
		];

		args.contextBuilder.patchGlobal({
			ui:"pum",
			dynamicUi : async (denops: Denops, args: Record<string, unknown>) =>{
				const uiArgs = args as {
					items: DdcItem[];
				};
				const mode = await fn.mode(denops);

				return Promise.resolve(
							mode !== "t" && uiArgs.items.length == 1 ? "inline" : "pum",
						);
				},
			dynamicSources: async (denops: Denops , args: Record<string , unknown> ) =>{
				const sourceArgs = args as {
						context: Context;
						sources: string[];
					};
				const mode = await fn.mode(denops);
				return Promise.resolve(
							mode === "c" && await fn.getcmdtype(denops) === ":" ?
							[sourceArgs.sources] : null,
						);
				},
			autoCompleteEvents: [
				"CmdlineEnter",
				"CmdlineChanged",
				"InsertEnter",
				"TextChangedI",
				"TextChangedP",
				"TextChangedT",
			],
			sources: commonSources,
			cmdlineSources: {
				":" : [
					"cmdline",
					"around",
					"register"
				],
				"@" : [
					"input",
					"file",
					"around",
				],
				">" : [
					"input",
					"file",
					"around",
				],
				"/" : [ "around" , "line" ],
				"?" : [ "around" , "line" ],
				"-" : [ "around" , "line" ],
				"=" : ["input", ],
			},
			sourceOptions: {
				_:{
					ignoreCase: true,
					matchers: [
						"matcher_head",
						"matcher_prefix",
						"matcher_length",
					],
					sorters:[
						"sorter_rank",
					],
					converters: [
						"converter_remove_overlap",
					],
					timeout: 1000,
				},
				around:{
							mark: "[Arround]",
					   },
				buffer:{
							mark: "[Buffer]",
					   },
				file:{
							mark: "[file]",
							isVolatile: true,
							minAutoCompleteLength: 1000,
							forceCompletionPattern: String.raw`\S/\S*`,
					   },
				input:{
							mark: "[input]",
							isVolatile: true,
							forceCompletionPattern: String.raw`\S/\S*`,
					   },
				line: {
							mark: "[Line]",
					  },
				lsp: {
						 "mark":"[LSP]",
						 forceCompletionPattern: String.raw`\.\w*+|::\w*->\w*`,
						 dup: "force",
					 },
				register: {
						mark: "[Register]",
					},
				rg:{
						mark: "[Rg]",
						minAutoCompleteLength: 5,
						enabledif: "finddir('.git' , ';') != ''",
				},
				skkeleton:{
							mark : "[Skkeleton]",
							matchers : [],
							sorters : [],
							minAutoCompleteLength: 2,
							isVolatile: true,
						  },
				skkeleton_okuri: {
							mark : "[Skkeleton*]",
							matchers : [],
							sorters : [],
							minAutoCompleteLength: 2,
							isVolatile: true,
								 },
				vim : {
					mark: "[Vim]",
					isVolatile : true,
					  },
				yank : { mark : "[Yank]", },
					   
			},
			sourceParams: {
				buffer : {
					requireSameFiletype: false,
					 limitBytes: 50000,
					 fromAltBuf: true,
					 forceCollect: true,
				 },
				file : {
					filenameChars: "[:keyword:].",
				},
				lsp:{
						enableAdditionalTextEdit : true,
						enableDisplayDetail: true,
						enableMatchLabel: true,
						enableResolceItem: true,
					},
				register:{
							registers: '0123456789"#:"',
						 },
			},
			filterParams: {
				postfilters: [
								 "sorter_head"
				],
			},
		});

		for( const filetype of [
				"markdown",
				"markdown_inline",
				"gitcommit",
				"comment",
		] ){
			args.contextBuilder.patchFiletype( filetype , {
						sources: [...commonSources, "line",],
					} );
		}

		for( const filetype of [ "html" , "css" ] )
		{
			args.contextBuilder.patchFiletype(filetype , {
						sourceOptions: {
							_:{
								keywordPattern: "[0-9a-zA-Z_./#:-]*",
							},
						sources:["around"],
						},
					});
		}

		// use "#" as TypeScript KeywordPattern
		for( const filetype of [ "typescript" ] )
		{
			args.contextBuilder.patchFiletype( filetype , {
						sourceOptions: {
							_: {
								keywordPattern : "#?[a-zA-Z_][0-9a-zA-Z_]*",
							},
						},
					});
		}

		for( const filetype of [
				"css",
				"go",
				"graphql",
				"html",
				"lua",
				"python",
				"ruby",
				"rust",
				"tsx",
				"typescript",
				"typescriptreact",
		] )
		{
			args.contextBuilder.patchFiletype( filetype, {
						sources: ["lsp" ,...commonSources],
					} );
		}

		args.contextBuilder.patchFiletype( "vim" , {
					specialBufferCompletion: true,
					sources: ["vim" , "cmdline" , ...commonSources],
				} );
	}
}
