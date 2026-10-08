<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ECA CrowdSec is a thin glue submodule of CrowdSec that exposes the CrowdSec module's events to ECA (Event-Condition-Action), so site builders can trigger no-code automations when CrowdSec bans, blocks, signals or lists scenarios.

---

It ships a single ECA event plugin, id `crowdsec`, with a deriver (`CrowdSecEventDeriver`) that produces six derivatives — one per CrowdSec event: `crowdsec:scenariolist`, `crowdsec:signalscenariolist`, `crowdsec:blocked`, `crowdsec:banned`, `crowdsec:unbanned`, `crowdsec:signalled`. Each derivative maps an ECA event to a `Drupal\crowdsec\Event\CrowdSecEvents` constant (e.g. `crowdsec:banned` → `crowdsec.ip.banned`). The plugin exposes event data as ECA tokens: `crowdsec_ip` (the IP, for the IP events), `crowdsec_scenario` (for the signalled event), and `crowdsec_scenario_list` (for the scenario-list events). It has no configuration form of its own (only per-event ECA plugin schema), no permissions, no services, and no Drush — all real behaviour lives in the parent `crowdsec` module. It depends on `crowdsec` and `eca` (^3). You use it by building an ECA model in the ECA UI (or via an `eca` config entity) whose event plugin is one of the `crowdsec:*` derivatives.

---

- Send an alert email whenever CrowdSec bans an IP (`crowdsec:banned`).
- Log to an external system every time an IP is blocked with a 403 (`crowdsec:blocked`).
- Post to Slack/Matrix when an IP is signalled upstream (`crowdsec:signalled`).
- Create a Drupal log/message entity on each CrowdSec ban without writing PHP.
- React when an IP is un-banned to clean up related records (`crowdsec:unbanned`).
- Add extra scenarios to the subscribe list programmatically via `crowdsec:scenariolist`.
- Extend the upstream signal-scenario list via `crowdsec:signalscenariolist`.
- Use the `crowdsec_ip` token to record which address triggered a ban.
- Use the `crowdsec_scenario` token to branch automation on the signalled scenario.
- Build a no-code moderation workflow that flags accounts from banned IPs.
- Trigger a webhook to a firewall/CDN when CrowdSec bans an address.
- Increment a counter or metric on each block/ban event.
- Notify site admins of a spike in signalled IPs.
- Chain CrowdSec bans into other ECA conditions/actions without custom code.
- Prototype CrowdSec event handling in the ECA modeller before writing bespoke subscribers.
- Store banned IPs into a custom entity list via ECA actions.
- Combine the `crowdsec_scenario_list` token with ECA to conditionally register scenarios.
- Drive different actions per event type using the six derivative events.
- Give non-developers control over CrowdSec reactions through the ECA UI.
- Test which CrowdSec events fire by attaching a simple ECA logging action.
