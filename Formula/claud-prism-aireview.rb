class ClaudPrismAireview < Formula
  desc "Multi-AI provider toolkit for Claude Code — cross-provider code review via Codex + Gemini"
  homepage "https://github.com/tznthou/claude-prism"
  url "https://github.com/tznthou/claude-prism/releases/download/v0.11.0/claude-prism-v0.11.0.tar.gz"
  sha256 "a7db0867b1398361a71711394f73df58bad06e748ba2120f690b3a032aa9f815"
  license "MIT"
  version "0.11.0"

  depends_on "bash"

  def install
    libexec.install "commands", "scripts", "install.sh", "uninstall.sh", "checksums.sha256"
    chmod 0755, Dir[libexec/"scripts/*.sh"]

    (bin/"claude-prism").write <<~SH
      #!/usr/bin/env bash
      exec bash "#{libexec}/install.sh" "$@"
    SH

    (bin/"claude-prism-uninstall").write <<~SH
      #!/usr/bin/env bash
      exec bash "#{libexec}/uninstall.sh" "$@"
    SH
  end

  def caveats
    <<~EOS
      Run 'claude-prism' to install commands to ~/.claude/

      To uninstall commands (without removing the brew formula):
        claude-prism-uninstall

      To check prerequisites only:
        claude-prism --check-only
    EOS
  end

  test do
    assert_match "claude-prism installer", shell_output("cat #{libexec}/install.sh")
  end
end
