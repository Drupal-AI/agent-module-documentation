<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CrowdSec — agent index

Integrates Drupal with the CrowdSec security network: **ban plugins** detect bad behaviour and ban IPs
locally, **signal scenarios** report chosen local bans upstream, and **subscribe scenarios** download
CrowdSec blocklists and enforce them (403 via HTTP middleware). Everything is driven by one config
object `crowdsec.settings`. Config UI at `/admin/config/services/crowdsec` (route `crowdsec.settings`,
permission `administer site configuration`). Requires the `crowdsec/remediation-engine` PHP lib.

- **All settings keys, the config form, defaults, dev/prod, scenarios** →
  [configure/settings.md](configure/settings.md)
- **The `crowdsec_scenario` plugin type + the 3 built-in plugins; writing your own** →
  [plugins/scenarios.md](plugins/scenarios.md)
- **Drush commands (enroll / signal / collect / test)** → [drush/commands.md](drush/commands.md)
- **Events, the Signals service, the alter hooks, cron** → [api/events.md](api/events.md)

Key facts: built-in ban plugins are `flood` (→ `drupal/auth-bruteforce`), `core-ban`
(→ `drupal/core-ban`), `whisper` (→ `drupal/4xx-scan`, buffered). Per-plugin settings live under
`crowdsec.settings` → `plugins.<id>.{enable,ban_duration,leak_speed,bucket_capacity}`. Bundled
submodule **eca_crowdsec** exposes CrowdSec events to ECA (documented separately under
`modules/eca_crowdsec/`). This site has **no live CrowdSec API/agent** — inspect and change local
config; do not expect upstream calls to succeed.
