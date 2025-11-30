class DailyDashboard < Formula
  desc "Terminal-based dashboard for news feeds, weather, and network scanning"
  homepage "https://github.com/grego360/daily-dashboard"
  url "https://files.pythonhosted.org/packages/3a/f7/1943136d8ac52260210cd4a4f19c44410f5edbac4b493bb936eb4927be38/daily_dashboard-0.1.5.tar.gz"
  sha256 "a1b974d8af92c718c9238349acf5798fd1079761710218cbd5aa75f8d0f692cc"
  license "MIT"

  depends_on "python@3.12"

  def install
    # Create a proper virtualenv with pip included
    system Formula["python@3.12"].opt_bin/"python3.12", "-m", "venv", libexec

    # Upgrade pip first
    system libexec/"bin/pip", "install", "--upgrade", "pip"

    # Install the package with all dependencies from PyPI
    system libexec/"bin/pip", "install", "daily-dashboard==0.1.5"

    # Create wrapper script
    (bin/"daily-dashboard").write <<~EOS
      #!/bin/bash
      exec "#{libexec}/bin/daily-dashboard" "$@"
    EOS
  end

  def caveats
    <<~EOS
      To use network scanning features, run with sudo:
        sudo daily-dashboard

      Create a config file to get started:
        curl -o config.json https://raw.githubusercontent.com/grego360/daily-dashboard/main/config.example.json

      Edit config.json to add your feeds, location, and network targets.
    EOS
  end

  test do
    assert_match "Daily Dashboard", shell_output("#{bin}/daily-dashboard --version")
  end
end
