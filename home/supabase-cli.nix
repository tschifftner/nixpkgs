{
  lib,
  stdenv,
  fetchzip,
  installShellFiles,
}:

stdenv.mkDerivation rec {
  pname = "supabase-cli";
  version = "2.30.4";

  src = fetchzip {
    url = "https://github.com/supabase/cli/releases/download/v${version}/supabase_darwin_arm64.tar.gz";
    hash = "sha256-9RbMzu3Nta40/aSSNAh8KhibytPmOYEwdF4bspGvKNw=";
    stripRoot = false;
  };

  nativeBuildInputs = [ installShellFiles ];

  installPhase = ''
    mkdir -p $out/bin
    cp supabase $out/bin/
    chmod +x $out/bin/supabase
    installShellCompletion --cmd supabase \
      --bash <($out/bin/supabase completion bash) \
      --fish <($out/bin/supabase completion fish) \
      --zsh <($out/bin/supabase completion zsh)
  '';

  meta = with lib; {
    description = "CLI for interacting with supabase (prebuilt binary)";
    homepage = "https://github.com/supabase/cli";
    license = licenses.mit;
    maintainers = [];
    platforms = [ "aarch64-darwin" ];
    mainProgram = "supabase";
  };
}
