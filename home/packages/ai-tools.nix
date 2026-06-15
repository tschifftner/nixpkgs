{ pkgs, ... }:

{
  # AI and machine learning tools
  home.packages = with pkgs; [
    ollama                # Run and manage large language models locally
    gemini-cli            # Google Gemini CLI
    gpt-cli               # CLI für ChatGPT, Claude und Bard
    code-cursor           # AI-powered code completion and navigation
  ];
}
