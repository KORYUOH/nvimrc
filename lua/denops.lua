vim.g["denops#debug"] = false

vim.g["denops#server#deno_args"] = {
	"-q",
	"-A",
}

-- Deno KV storage

-- table.insert( vim.g["denops#server#deno_args"] , "--unstable-kv" )

-- deno-pty-ffi
-- table.insert( vim.g["denops#server#deno_args"] , "--unstable-ffi" )

-- プロファイル
-- table.insert( vim.g["denops#server#deno_args"] , "--inspect" )

-- アドレスの指定
-- vim.g.denops_server_addr = "127.0.0.1:32123"

