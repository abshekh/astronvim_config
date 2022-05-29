-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local workspace_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local lombok = vim.fn.expand('~/.jars/lombok/lombok-1.18.25.jar')

local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {
    vim.fn.expand('~/.sdkman/candidates/java/11.0.15-tem/bin/java'),
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1g',
    '-javaagent:' .. lombok,
    '-Xbootclasspath/a:' .. lombok,
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-jar', vim.fn.expand('~/.jars/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar'),
    '-configuration', vim.fn.expand('~/.jars/jdtls/config_linux/'),
    '-data', vim.fn.expand('~/.cache/jdtls-workspace') .. workspace_dir,
  },

  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
  capabilities = capabilities,

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  -- settings = {
  --   java = {
  --   }
  -- },

  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  -- init_options = {
  --   bundles = {}
  -- },
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)



local map = vim.keymap.set
local opts = { noremap=true, silent=true }

local function get_opts(t1, t2)
  local merged = {}
  for k,v in pairs(t1) do merged[k] = v end
  for k,v in pairs(t2) do merged[k] = v end

  return merged
end

map("n", "K",
    function() vim.lsp.buf.hover() end,
    get_opts(opts, { desc = "Hover symbol details" }))
map("n", "<leader>la",
    function() vim.lsp.buf.code_action() end,
    get_opts(opts, { desc = "LSP code action" }))
map("n", "<leader>lf",
    function() vim.lsp.buf.formatting_sync() end,
    get_opts(opts, { desc = "Format code" }))
map("n", "<leader>lh",
    function() vim.lsp.buf.signature_help() end,
    get_opts(opts, { desc = "Signature help" }))
map("n", "<leader>lr",
    function() vim.lsp.buf.rename() end,
    get_opts(opts, { desc = "Rename current symbol" }))
map("n", "gD",
    function() vim.lsp.buf.declaration() end,
    get_opts(opts, { desc = "Declaration of current symbol" }))
map("n", "gI",
    function() vim.lsp.buf.implementation() end,
    get_opts(opts, { desc = "Implementation of current symbol" }))
map("n", "gd",
    function() vim.lsp.buf.definition() end,
    get_opts(opts, { desc = "Show the definition of current symbol" }))
map("n", "gr",
    function() vim.lsp.buf.references() end,
    get_opts(opts, { desc = "References of current symbol" }))
map("n", "<leader>ld",
    function() vim.diagnostic.open_float() end,
    get_opts(opts, { desc = "Hover diagnostics" }))
map("n", "[d",
    function() vim.diagnostic.goto_prev() end,
    get_opts(opts, { desc = "Previous diagnostic" }))
map("n", "]d",
    function() vim.diagnostic.goto_next() end,
    get_opts(opts, { desc = "Next diagnostic" }))
map("n", "gl",
    function() vim.diagnostic.open_float() end,
    get_opts(opts, { desc = "Hover diagnostics" }))
map("n", "<leader>lf",
    function() vim.lsp.buf.formatting() end,
    get_opts(opts, { desc = "Format file with LSP" }))
