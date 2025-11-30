class DailyDashboard < Formula
  desc "Terminal-based dashboard for news feeds, weather, and network scanning"
  homepage "https://github.com/grego360/daily-dashboard"
  url "https://files.pythonhosted.org/packages/51/0f/c9276f7dfa47a48fa73e519c87e4966fe9004754af908bcc547a6013f94e/daily_dashboard-0.1.1.tar.gz"
  sha256 "93a245460274a9294d6f14ed84b4ff5388e696f6405a96d54ca82df307528f8e"
  license "MIT"

  depends_on "python@3.12"

  def install
    # Create a proper virtualenv with pip included
    system Formula["python@3.12"].opt_bin/"python3.12", "-m", "venv", libexec

    # Upgrade pip first
    system libexec/"bin/pip", "install", "--upgrade", "pip"

    # Install the package with all dependencies from PyPI
    system libexec/"bin/pip", "install", "daily-dashboard==0.1.1"

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
