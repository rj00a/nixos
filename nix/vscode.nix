{ pkgs, extra-extensions ? [ ] }:
with pkgs;
with vscode-extensions;
vscode-with-extensions.override {
  vscodeExtensions = extra-extensions ++ [
    arcticicestudio.nord-visual-studio-code
    bbenoist.nix
    brettm12345.nixfmt-vscode
    haskell.haskell
    justusadam.language-haskell
    matklad.rust-analyzer
    ms-azuretools.vscode-docker
    ms-kubernetes-tools.vscode-kubernetes-tools
    pkief.material-icon-theme
    redhat.vscode-yaml
    timonwong.shellcheck
    vadimcn.vscode-lldb
    maximedenes.vscoq
    redhat.java
    vscjava.vscode-java-dependency
    tamasfe.even-better-toml
    ms-vscode.cpptools
  ] ++ vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "vscode-todo-highlight";
      publisher = "wayou";
      version = "1.0.5";
      sha256 =
        "09056d31db7f7d970d21b1ff2b26c98b19cba82b33e6217553493e19f2fae4e9";
    }
    {
      name = "vscode-gradle";
      publisher = "vscjava";
      version = "3.12.2023031100";
      sha256 =
        "0b763d6f4bf4f7b3852ef992da3ed20c4fbe4aa491be4e753c24e7d15648b708";
    }
    #{
    #  name = "wgsl";
    #  publisher = "PolyMeilex";
    #  version = "0.1.14";
    #  sha256 =
    #    "1491f2c3bbc220ab625210b6ab5f98b714f7a0b611c9217d5e93bf45b1ae033c";
    #}
    {
      name = "vscode-zig";
      publisher = "ziglang";
      version = "0.3.2";
      sha256 =
        "b331bf166f3a45658d21321836f090984bfcb71d95080c6d917c90adbed6b27e";
    }
    #{
    #  name = "lean4";
    #  publisher = "leanprover";
    #  version = "0.0.63";
    #  sha256 =
    #    "92311ec7b2f41763f8a4c7578b8348675cb9f72c0956e6ea0eab2861a8193642";
    #}
    {
      name = "github-vscode-theme";
      publisher = "GitHub";
      version = "6.3.4";
      sha256 = "25b23407b8f1b7fda9360fe1323004e690416b72db51d8be185d221195035033";
    }
    {
      name = "mesonbuild";
      publisher = "mesonbuild";
      version = "1.21.0";
      sha256 = "86c59bd444b657f7b5829ddb40c2f84da3a207f5d0f101fa2c2239656bec9b92";
    }
  ];
}
