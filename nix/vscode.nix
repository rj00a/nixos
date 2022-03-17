# TODO: Make my own theme based on alduin

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
  ] ++ vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "vscode-todo-highlight";
      publisher = "wayou";
      version = "1.0.5";
      sha256 =
        "09056d31db7f7d970d21b1ff2b26c98b19cba82b33e6217553493e19f2fae4e9";
    }
    {
      name = "lean4";
      publisher = "leanprover";
      version = "0.0.63";
      sha256 =
        "92311ec7b2f41763f8a4c7578b8348675cb9f72c0956e6ea0eab2861a8193642";
    }
  ];
}
