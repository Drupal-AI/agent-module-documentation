Pre-configured sample alert rules for API Orchestrator, wired to Slack and Discord channels, with setup instructions for webhook URLs.

---

This sample installs example `api_orchestrator_alert` rules that demonstrate the Alerts submodule with the Slack and Discord alert channels, and includes a README explaining how to supply webhook URLs (typically via environment-variable tokens like `{{env:SLACK_WEBHOOK_URL}}`). It is a demonstration/starter package rather than production configuration. Requires `api_orchestrator`, `api_orchestrator_integration_samples` and `api_orchestrator_alerts`.

---

- See working alert-rule configuration you can copy and adapt.
- Try Slack and Discord alert channels with minimal setup.
- Learn how to supply webhook URLs via env tokens.
- Understand threshold, time-window, severity and cooldown settings by example.
- Kick-start alerting on a new API Orchestrator install.
- Remove the sample rules cleanly when done.
