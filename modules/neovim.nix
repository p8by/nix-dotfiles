{
  flake.modules.nixos.neovim = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.nixd pkgs.pyright ];
    programs.neovim = {
      enable = true;
      configure = {
        customRC = ''
          set ai
          set number
          set relativenumber
          let g:lightline = { 'colorscheme': 'moonfly'}
          colorscheme moonfly
          lua require("nvim-autopairs").setup({})
          lua require("nvim-treesitter").setup()
          lua require("hlchunk").setup({ chunk = { enable = true }, indent = { enable = true } })
          lua <<EOF
            local cmp = require("cmp")
            cmp.setup({
              snippet = {
                expand = function(args)
                  require("luasnip").lsp_expand(args.body)
                end,
              },
              mapping = cmp.mapping.preset.insert({
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
                ["<Tab>"] = cmp.mapping.select_next_item(),
                ["<S-Tab>"] = cmp.mapping.select_prev_item(),
              }),
              sources = {
                { name = "nvim_lsp" },
                { name = "luasnip" },
              },
            })
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            vim.lsp.config("nixd", { capabilities = capabilities})
            vim.lsp.enable("nixd")
            vim.lsp.config("pyright", { capabilities = capabilities})
            vim.lsp.enable("pyright")
            vim.lsp.config("clangd", { capabilities = capabilities})
            vim.lsp.enable("clangd")
EOF
        '';
        packages.package.start = with pkgs.vimPlugins; [
          nvim-autopairs
          nvim-treesitter.withAllGrammars
          lightline-vim
          vim-moonfly-colors
          nvim-lspconfig
          nvim-cmp
          cmp-nvim-lsp
          luasnip
          cmp_luasnip
          hlchunk-nvim
        ];
      };
    };
  };
}
