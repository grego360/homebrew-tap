class DailyDashboard < Formula
  desc "Terminal-based dashboard for news feeds, weather, and network scanning"
  homepage "https://github.com/grego360/daily-dashboard"
  url "https://files.pythonhosted.org/packages/93/9e/fb60d3e78f32eade33cccf15913d9f1ba3e946efbd6e3bb35f61b4e39eac/daily_dashboard-0.1.2.tar.gz"
  sha256 "e25c72c6373d4e6261fc0e947043c5a757e27826abc2500392ffbbf5f78f1cd0"
  license "MIT"

  depends_on "python@3.12"

  def install
    # Create a proper virtualenv with pip included
    system Formula["python@3.12"].opt_bin/"python3.12", "-m", "venv", libexec

    # Upgrade pip first
    system libexec/"bin/pip", "install", "--upgrade", "pip"

    # Install the package with all dependencies from PyPI
    system libexec/"bin/pip", "install", "daily-dashboard==0.1.2"

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
