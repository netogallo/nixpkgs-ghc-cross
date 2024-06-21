{
  pkgs ? import <nixpkgs> {}
}:
let
  haskellLibUncomposable = import ./development/haskell-modules/lib {
    inherit (pkgs) lib;
    inherit pkgs;
  };

  callPackage = pkgs.newScope {
    haskellLib = haskellLibUncomposable.compose;
    overrides = pkgs.haskell.packageOverrides;
  };
in
{
    #ghc982-javascript = callPackage ./compilers/ghc/9.8.2.nix {
    ghc965-javascript = callPackage ./compilers/ghc/9.6.5.nix {
      bootPkgs = pkgs.haskell.packages.ghc946;
      inherit (pkgs.buildPackages.python3Packages) sphinx;
      # Need to use apple's patched xattr until
      # https://github.com/xattr/xattr/issues/44 and
      # https://github.com/xattr/xattr/issues/55 are solved.
      inherit (pkgs.buildPackages.darwin) xattr autoSignDarwinBinariesHook;
      # Support range >= 11 && < 16
      buildTargetLlvmPackages = pkgs.llvmPackages_15;
      llvmPackages = pkgs.llvmPackages_15;
    };
 
}

