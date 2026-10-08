<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API Orchestrator - Sample: Alert Rules (api_orchestrator_sample_alerts) — agent index

Demo alert-rule configuration. Depends on `api_orchestrator`, `api_orchestrator_integration_samples`, `api_orchestrator_alerts`. Config-only (no PHP `src/`); ships a README.

## Provides
- Example `api_orchestrator_alert` config entities wired to the `slack` and `discord` `AlertChannel` plugins, installed via `config/install`; README documents supplying webhook URLs (e.g. `{{env:SLACK_WEBHOOK_URL}}` / `{{env:DISCORD_WEBHOOK_URL}}`).
- `hook_install`/`hook_uninstall` add and clean up the sample alert rules.

See the parent Alerts submodule (`../../api_orchestrator_alerts/1.1.x/agent/start.md`) for the alert entity and channel plugin details.
