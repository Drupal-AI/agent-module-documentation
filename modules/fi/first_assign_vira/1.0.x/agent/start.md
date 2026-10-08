<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Auto Term (first_assign_vira) — agent index

**Auto-creates a taxonomy term mirroring an entity's title on creation, with a bulk backfill batch.** (project `first_assign_vira`; internal module name `eat`.)

- **Version:** 1.0.x
- **Core:** `^9 || ^10`. **Package:** Taxonomy. **Dep:** views.
- **Configure:** `/admin/config/system/eat` (`eat.settings`, `administer site configuration`) — entity/bundle → vocabulary mappings.
- **Batch:** `/admin/config/system/eat/batch` (`eat.batch_update`) runs `Eat::matchupEntitiesToSet()`.
- **Logic:** `hook_form_alter` adds `eat_form_submit`; `Eat::addTerm()`/`checkIfExists()`; custom `eat` DB table. **Views plugin:** `EatFilters` (argument_default).

**Security:** The settings route is admin-gated. Not a role/privilege module (assigns taxonomy terms, not roles — no privesc). Note: the bulk `eat.batch_update` route is gated only by `_permission: 'access content'` (granted to anonymous by default) while it triggers a site-wide term-creation mutation — reported to the campaign as overbroad access.

See [configure/mappings.md](configure/mappings.md).