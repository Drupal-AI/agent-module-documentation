<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Acquia Personalization (Perz) Push — agent index

The content-export engine for `acquia_perz`. Renders opted-in entity view modes and pushes them
to Acquia's Content Index Engine (CIS); tracks exports; adds Drush + admin forms. No configure
route of its own — global config is on the parent module's settings form.

- **Drush commands (enqueue / process / purge / count / delete)** →
  [drush/commands.md](drush/commands.md)
- **Config (`acquia_perz_push.settings`), admin forms, tracking table, queue workers** →
  [configure/config.md](configure/config.md)
- **Export services & API (`ExportContent`, `ExportQueue`, `ExportTracker`)** →
  [api/services.md](api/services.md)

Key facts:
- Permission: `administer acquia perz push` (gates the Export and Delete forms).
- Config object: `acquia_perz_push.settings` → `cis.queue_bulk_max_size` (20), `cis.endpoint_timeout` (2).
- Tracking table: `acquia_perz_push_export_tracking`.
- Queue workers: `acquia_perz_push_content_export`, `acquia_perz_push_content_export_bulk`.
- Enabling this submodule makes `PerzHelper::runDecisionWebhook()` in the parent a no-op — export
  goes through this submodule's entity hooks instead.
