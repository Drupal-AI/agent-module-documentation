<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Usage Updater (entity_usage_updater) — agent index
**Bulk-repoint or remove entity references that Entity Usage tracks.**

- **Version:** 2.0.x (2.0.0 release)
- **Core:** ^11.2 (no explicit PHP constraint declared; core ^11.2 implies PHP 8.3+)
- **Depends:** entity_usage:entity_usage (^5.0@beta); Composer: `ext-dom`, `drupal/entity_usage:^5.0.1`
- **Routes:** `/admin/content/update-references` (update), `/admin/config/content/link-remover` (remove by URL), `/admin/config/content/entity-usage-updater` (settings)
- **Permissions:** `update referenced entities` (restrict access: true) for both mutating forms; `administer site configuration` for settings
- **Plugin type:** `EntityUsageUpdater` (`Plugin/EntityUsageUpdater`, attribute + annotation discovery) — shipped plugins: `entity_reference`, `html_link`, `link`, `linkit`

**What changed vs 1.0.x:** requires Drupal core ^11.2 (D10 support dropped) and Entity Usage 5.x (`^5.0@beta` / composer `^5.0.1`, was 8.x-2.x); explicit `ext-dom` Composer requirement; Link remover now takes a list of URLs and can unpublish / change moderation state of affected entities; new content_moderation integration (per-workflow `default_unpublished_state` third-party setting + `workflow_presave` hook) and Redirect-module integration; Paragraphs handled inline (walks the paragraph tree) to match Entity Usage 5.x tracking; the update form is embedded on an entity's Entity Usage tab via a route subscriber.

**How it works:** forms collect a source/target (or URL list), then `EntityUsageUpdater::update()` / `remove()` build a Batch that loads each host entity reported by Entity Usage, rewrites only the latest revision through the matching updater plugin, re-validates (via `ViolationsHelper`, refusing to save if violations increase), and saves a new revision with an explanatory log message.

**Operational note:** these operations are high-privilege — a single run can rewrite content site-wide, create new revisions, unpublish content, or change moderation states across every host entity that references the target. Grant `update referenced entities` (declared `restrict access: true`) and `administer site configuration` only to trusted administrators, review who can reach the update/remove surfaces, and back up before running bulk updates.

See [configure/usage.md](configure/usage.md).
