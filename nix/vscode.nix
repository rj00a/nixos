# TODO: Make my own theme based on alduin

{ pkgs, extra-extensions ? [ ] }:
with pkgs;
with vscode-extensions;
vscode-with-extensions.override {
  vscodeExtensions = extra-extensions ++ [
    matklad.rust-analyzer
    # TODO currently broken on unstable.
    #vadimcn.vscode-lldb
    vscodevim.vim
    redhat.vscode-yaml
    bbenoist.Nix
  ] ++ vscode-utils.extensionsFromVscodeMarketplace [
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
      version = "0.14.0";
      sha256 =
        "5197411965580b6ec3773e649ab30c08ed80ed997a48fb50e297ea668a6ab722";
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
    {
      name = "github-plus-theme";
      publisher = "thenikso";
      version = "1.2.1";
      sha256 =
        "63074df2b378bc247191a25536bcf43045689b093edd979f75a10645dc23391b";
    }
    {
      name = "nord-visual-studio-code";
      publisher = "arcticicestudio";
      version = "0.15.1";
      sha256 =
        "1223b3a0775e779c2ca069d260dd5defb073f0b40d4fcaaf737be0cea7048551";
    }
    {
      name = "august-themes";
      publisher = "inci-august";
      version = "2.2.3";
      sha256 =
        "60186d21b2410986b526e4749378cc5bc4d390bd7563afa64bb2b3167f9f6c1b";
    }
  ];
}
