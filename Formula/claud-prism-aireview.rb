class ClaudPrismAireview < Formula
  desc "Multi-AI provider toolkit for Claude Code — cross-provider code review via Codex + Gemini"
  homepage "https://github.com/tznthou/claude-prism"
  url "https://github.com/tznthou/claude-prism/releases/download/v0.8.1/claude-prism-v0.8.1.tar.gz"
  sha256 "74135f528a03bc4b2ae2cd583ef7b86cd5fb755cf4890c8463abf9db9d92cd78"
  license "MIT"
  version "0.8.1"

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
