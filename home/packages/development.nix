{ pkgs, ... }:

{
  # Development tools and programming languages
  home.packages = with pkgs; [
    # Core development
    nodejs                  # Node.js runtime
    python312               # Python 3.12 runtime
    typescript              # TypeScript compiler
    concurrently           # Run commands concurrently
    biome                  # JavaScript and TypeScript linter, formatter, and bundler
    
    # Source code analysis
    cloc                   # Source code line counter
    
    # Version control
    github-copilot-cli    # GitHub Copilot CLI
    
    # Web development
    firebase-tools        # Command line tools for Firebase
    
    # API and cloud tools
    s3cmd                 # Command line tool for managing Amazon S3 and CloudFront
    yq                    # Command-line YAML processor, similar to jq
    
    # Shell scripting
    shfmt                 # Shell script formatter
    
    # Container tools
    colima                # Container runtime with support for Docker and Kubernetes  
    docker                # Container runtime
    docker-compose        # Tool for defining and running multi-container Docker applications
  ];
}
