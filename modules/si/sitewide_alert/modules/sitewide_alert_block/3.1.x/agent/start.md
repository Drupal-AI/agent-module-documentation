<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sitewide Alert Block — agent index

Submodule of **sitewide_alert** (see `../../../../3.1.x/agent/start.md`).

Provides one Block plugin: **`sitewide_alert_block`** (class `SitewideAlertBlock`,
admin label "Sitewide Alert"). Enable the submodule, then place the block in a
theme region at `/admin/structure/block` or inside a Layout Builder layout to
render alerts where you choose instead of the parent module's default
top-of-page injection. No config form, no permissions, no schema of its own —
it reuses the parent's alert entities and settings.

Enable: `drush en sitewide_alert_block -y`.
