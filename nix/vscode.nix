# TODO: Make my own theme based on alduin

{ pkgs, extra-extensions ? [ ] }:
with pkgs;
with vscode-extensions;
vscode-with-extensions.override {
  vscodeExtensions = extra-extensions ++ [
    matklad.rust-analyzer
    vadimcn.vscode-lldb
    #vscodevim.vim
    redhat.vscode-yaml
    bbenoist.nix
    arcticicestudio.nord-visual-studio-code
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
      version = "0.14.4";
      sha256 =
        "95fc8f343c41322eb21d16ff7bfb100b86ef40e5ac1d49f1a81edbc43509e317";
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
      name = "shader";
      publisher = "slevesque";
      version = "1.1.5";
      sha256 =
        "3dfdfb15e40c365bfbe1fecb333f7e08ab1c17a5234d9ed9a5c69914ab57d993";
    }
    #{
    #  name = "glsl-canvas";
    #  publisher = "circledev";
    #  version = "0.2.14";
    #  sha256 =
    #    "af93ac2ba49270b63b135e91480a3f589dd5df1beb56a14852cc12d5ec19326c";
    #}
    {
      name = "shader-toy";
      publisher = "stevensona";
      version = "0.10.15";
      sha256 =
        "dbd7a3d59bfc6548f711aed9071a981faaf8bc38c33c9cec60c0a69e9dfe6ab4";
    }
  ];
}
