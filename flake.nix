{
  outputs = { self, nixpkgs, utils }:
    utils.defaultSystems
      ({ pkgs, system }: with pkgs;
        {
          packages =
            let
              nodePackages = callPackage ./. {};
            in
              nodePackages
                // { elm-git-install =
                    nodePackages."elm-git-install-git://github.com/robinheghan/elm-git-install";
                  };

          devShell = mkShell {
            buildInputs = [
              nodePackages.node2nix
            ];
          };
        }
      )
      nixpkgs;
}
