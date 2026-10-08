<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECA CrowdSec — agent index

Glue submodule of CrowdSec. Exposes CrowdSec's events to **ECA** as one event plugin (id `crowdsec`)
with six derivatives. No config form (`configure: null`), no permissions, no services, no Drush — all
real logic lives in the parent `crowdsec` module. Depends on `crowdsec` + `eca` (^3).

- **The six ECA events, their mapping to CrowdSec event constants, and the exposed tokens** →
  [api/events.md](api/events.md)

Key fact: the ECA event plugin ids are `crowdsec:scenariolist`, `crowdsec:signalscenariolist`,
`crowdsec:blocked`, `crowdsec:banned`, `crowdsec:unbanned`, `crowdsec:signalled`. Use one as the event
plugin of an `eca` model to trigger a no-code automation.
