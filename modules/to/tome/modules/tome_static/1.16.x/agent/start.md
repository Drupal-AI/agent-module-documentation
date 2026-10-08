<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tome Static — agent index

Renders every public path of the Drupal site to static HTML in `tome_static_directory`
(default `../html`). CLI-first (`drush tome:static`), with an admin UI under
`/admin/config/tome/static` gated by the `use tome static` permission. No config object —
directories/excludes are `settings.php` keys; build progress lives in state.

- **Drush commands (`tome:static`, `tome:static-export-path`, `tome:preview`)** →
  [drush/commands.md](drush/commands.md)
- **Settings.php keys, admin UI routes, permission, state keys** →
  [configure/settings-and-ui.md](configure/settings-and-ui.md)
- **Extension events (collect paths, modify HTML, destination, file saved)** →
  [api/events.md](api/events.md)

Key facts: always pass `--uri=https://your-site` to `tome:static` for correct absolute URLs;
state key `tome_static.url` holds the last build URL, `tome_static.building` is the in-progress
guard. Rendered output is cached in the `cache.tome_static` bin so unchanged paths are skipped.
