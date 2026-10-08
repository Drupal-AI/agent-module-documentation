<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Migrate SourceId provides a block that, on a migrated entity's page, shows a link back to the original source entity — for example `{OLD_DRUPAL_URL}/node/{sourceid1}` — by reading the migration map tables. It is essentially a reverse `migrate_lookup`.
---
The problem it solves: after a migration you often want to verify or reference where a Drupal entity came from, without adding a custom field to store the old id. This module reads the `migrate_map_*` tables (populated by core Migrate) to recover the `sourceid1` for the current entity and renders it as a link. Configuration is done through `migrate_sourceid.settings` config (shipped in `config/install`): a `source_url` base and a `migrations` map listing, per entity type (node, taxonomy_term, user, media, file, block_content, …), the migration ids to look up. There is no admin form yet — you export config, edit `migrate_sourceid.settings.yml` (or override via `settings.php`), import and clear caches.

Operationally you enable the module after migrations are complete, place a "Migrate Sourceid" block and restrict it (e.g. to `/node/*`, `/taxonomy/term/*`) via block visibility. The lookup uses the core Migrate map tables via the database API. The module currently ships no permissions, routes or services of its own — its surface is the single block plugin — so restrict the block's visibility/roles as appropriate since it can reveal source-system ids/URLs.
---
- Enable after completing one or more migrations (requires core `migrate`).
- Place a "Migrate Sourceid" block on Block Layout.
- Show the block only on entity view pages (e.g. `/node/*`).
- Configure `source_url` to the old site base URL.
- List migration ids per entity type in `migrations`.
- Map node migrations (e.g. `d7_node`, custom CSV migrations).
- Map taxonomy_term migrations (e.g. `d7_taxonomy_term`).
- Map user migrations (e.g. `d6_user`).
- Map media/file/block_content migrations.
- Recover the old `sourceid1` for the current entity.
- Render a link to the source entity on the old site.
- Verify migration provenance during QA.
- Cross-check migrated content against the legacy system.
- Override settings via `settings.php` instead of config import.
- Export/import `migrate_sourceid.settings.yml` to deploy config.
- Reverse-lookup without adding a custom tracking field.
- Restrict block visibility to admins/editors reviewing content.
