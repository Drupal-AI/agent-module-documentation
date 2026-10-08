<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Open Y Upgrade Tool (upgrade_tool) — agent index

Tracks which configuration a site has **customised away from its distribution's defaults**, with a
dashboard and per-item **config diff**. Depends on the **config_import** module (project
`drupal/confi` `^4.0.0`). Version **4.2.0**.
**Core requirement `^11` — Drupal 11 only** (composer pins `drupal/core >=11.0.13`).

**Name mismatch:** project `upgrade_tool`, module **`openy_upgrade_tool`** — `drush en upgrade_tool`
fails. It comes from **Open Y / YMCA Website Services**.

**The problem it solves is genuinely hard and belongs to distributions.** A distribution ships
configuration; the site customises some of it. On update, importing wholesale **destroys the
customisations**; importing nothing means the site **never receives the improvements it upgraded
for**. The update needs to know, per config object, whether the site has taken ownership.

**How it works:** a decorating config installer plus a config-save `event_subscriber` watch every
config from an extension whose machine name contains **`openy`** (config dirs `config/install` +
`config/optional`) and log any manual divergence to `openy_upgrade_log` entities. The dashboard at
`/admin/openy/development/upgrade-log/dashboard` lists conflicts; per item you can **force the
distribution version**, **keep the current version**, or **manually merge**. Programmatic entry
points: services `openy_upgrade_log.manager` (loadByName / applyOpenyVersion /
applyCurrentActiveVersion / updateExistingConfig), `openy_upgrade_tool.param_updater` (revert one
config property), and `openy_upgrade_tool.importer` (import whole configs from a directory).

**Extend it:**
- [Config event ignore plugins](plugins/config_event_ignore.md) — declare config-type-specific
  rules for changes the tracker should treat as noise (e.g. Views `cache_metadata`).

**Two things worth noting:**
- **The routing paths begin with a space** — `' /admin/openy/development/upgrade-log/…'`. A
  packaging slip; verify actual reachability.
- **The pattern generalises.** Any site inheriting configuration from a shared upstream — an
  agency base profile, a multi-site platform, a **recipe** applied at build time — has the same
  problem, and a record of what has been customised is what makes upstream updates **applicable
  rather than theoretical**.
