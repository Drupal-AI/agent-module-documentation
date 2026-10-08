<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tome — agent index

Static site generator + flat-file content store for Drupal. `tome` is an umbrella that
depends on **tome_sync** (content/config/files ↔ JSON) and **tome_static** (site → static
HTML), both built on **tome_base**. No config entity, no `configure` route, no permissions
of its own — the work is done through Drush and `settings.php`. Everything real lives in the
sub-modules (documented in their own trees).

- **All Drush commands (export, import, static, preview, clean-files)** →
  [drush/commands.md](drush/commands.md)
- **Where output goes / `settings.php` keys** → [configure/settings.md](configure/settings.md)
- **Extension points (Tome Sync + Tome Static events)** → [api/events.md](api/events.md)

Sub-modules (each has its own docs under `modules/<name>/1.16.x/`):
- `tome_base` — shared services/traits and the `CommandBase` all `tome:*` commands extend.
- `tome_static` — `drush tome:static`, static HTML generation, `/admin/config/tome/static`.
- `tome_sync` — `drush tome:export` / `tome:import`, JSON content store, `/admin/config/tome/sync`.
- `tome_static_cron` — queue-worker static builds on cron (config `tome_static_cron.settings`).
- `tome_static_super_cache` — keeps Tome Static cache alive across cache clears; Views "Smart tag based" cache plugin.
- `tome_sync_autoclean` — (experimental) auto-runs clean-files on every export.

Key facts: default workflow is `drush tome:export` once, then edits auto-export; ship with
`drush tome:static --uri=https://your-site`. There is **no `tome.settings` config object** —
directories are set in `settings.php`.
