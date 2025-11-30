class DailyDashboard < Formula
  desc "Terminal-based dashboard for news feeds, weather, and network scanning"
  homepage "https://github.com/grego360/daily-dashboard"
  url "https://files.pythonhosted.org/packages/93/db/76f876b5045855c3c1dc0e8e5bb32bda8350819c31a0a7b2b005f02b41cd/daily_dashboard-0.1.4.tar.gz"
  sha256 "b4f1ad6402f8eee8ea7ff86ce05549694dbb638db4d3f922964f766e1d9ed195"
  license "MIT"

  depends_on "python@3.12"

  def install
    # Create a proper virtualenv with pip included
    system Formula["python@3.12"].opt_bin/"python3.12", "-m", "venv", libexec

    # Upgrade pip first
    system libexec/"bin/pip", "install", "--upgrade", "pip"

    # Install the package with all dependencies from PyPI
    system libexec/"bin/pip", "install", "daily-dashboard==0.1.4"

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
