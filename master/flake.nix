{
  description = ''A easy to use Nimscript interop package'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-nimscripter-master.flake = false;
  inputs.src-nimscripter-master.ref   = "refs/heads/master";
  inputs.src-nimscripter-master.owner = "beef331";
  inputs.src-nimscripter-master.repo  = "nimscripter";
  inputs.src-nimscripter-master.type  = "github";
  
  inputs."github-disruptek-assume".owner = "nim-nix-pkgs";
  inputs."github-disruptek-assume".ref   = "master";
  inputs."github-disruptek-assume".repo  = "github-disruptek-assume";
  inputs."github-disruptek-assume".dir   = "0_6_0";
  inputs."github-disruptek-assume".type  = "github";
  inputs."github-disruptek-assume".inputs.nixpkgs.follows = "nixpkgs";
  inputs."github-disruptek-assume".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-nimscripter-master"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-nimscripter-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}