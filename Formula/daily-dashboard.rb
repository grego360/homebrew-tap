class DailyDashboard < Formula
  desc "Terminal-based dashboard for news feeds, weather, and network scanning"
  homepage "https://github.com/grego360/daily-dashboard"
  url "https://files.pythonhosted.org/packages/bb/15/b9c6f86fa2f1e19f2d9e02e54488fa390083b884396c067fbfcd4e60c620/daily_dashboard-0.1.3.tar.gz"
  sha256 "3bdeee61daca7022f113cfe0e8d71b17f67fa51ac884f6ee97ea37c2767c3507"
  license "MIT"

  depends_on "python@3.12"

  def install
    # Create a proper virtualenv with pip included
    system Formula["python@3.12"].opt_bin/"python3.12", "-m", "venv", libexec

    # Upgrade pip first
    system libexec/"bin/pip", "install", "--upgrade", "pip"

    # Install the package with all dependencies from PyPI
    system libexec/"bin/pip", "install", "daily-dashboard==0.1.3"

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
