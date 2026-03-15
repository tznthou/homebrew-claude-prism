class ClaudPrismAireview < Formula
  desc "Multi-AI provider toolkit for Claude Code — cross-provider code review via Codex + Gemini"
  homepage "https://github.com/tznthou/claude-prism"
  url "https://github.com/tznthou/claude-prism/releases/download/v0.9.9/claude-prism-v0.9.9.tar.gz"
  sha256 "8bbf50ed5a86bb9f3908c1c2439e7e8c38be4767ecc29e2f8987224ef0078730"
  license "MIT"
  version "0.9.9"

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
