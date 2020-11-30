# TODO: Make my own theme based on alduin
# TODO: add settings.json and keybindings.json to configuration

{ pkgs, extra-extensions ? [ ] }:
with pkgs;
with vscode-extensions;
vscode-with-extensions.override {
  vscodeExtensions = extra-extensions ++ [
    matklad.rust-analyzer
    vadimcn.vscode-lldb
    vscodevim.vim
    redhat.vscode-yaml
    bbenoist.Nix
  ] ++ vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "theme-dracula";
      publisher = "dracula-theme";
      version = "2.22.3";
      sha256 =
        "869f334c553ae9bb7f64af1aed599019753729325a789a5164a4d818b34ed172";
    }
    {
      name = "nixfmt-vscode";
      publisher = "brettm12345";
      version = "0.0.1";
      sha256 =
        "f3282540351cd025c6d84322dbf1d70c9b31997278607be33634cc9d0c2b831f";
    }
    {
      name = "material-icon-theme";
      publisher = "pkief";
      version = "4.3.0";
      sha256 =
        "3020202de6f572528f7c194b7c74f5d7c242cd9e27f44239bd8cb4076b9bc9a8";
    }
    {
      name = "shellcheck";
      publisher = "timonwong";
      version = "0.12.1";
      sha256 =
        "e27f052ac1be3f9a1384a5958baf775836d8f957640bbf8d2f53b60a925efb2a";
    }
    {
      name = "toml";
      publisher = "be5invis";
      version = "0.5.1";
      sha256 =
        "5260ce315efba71a8648e0d445fc0c6dc597fa1a7af5a4226c39178ef3343ee4";
    }
    {
      name = "vscode-todo-highlight";
      publisher = "wayou";
      version = "1.0.4";
      sha256 =
        "39d3dc40d66fe79bf630691c7170f4aa68261ad5e7992e80d9572363562e2269";
    }
  ];
}
