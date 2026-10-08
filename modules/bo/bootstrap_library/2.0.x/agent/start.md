<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bootstrap Library — agent index

Attaches Bootstrap's CSS/JS to page requests. One config object
(`bootstrap_library.settings`), one settings form, one route, four asset libraries. **No
permissions of its own, no Drush, no plugins, no entities.**

- **Every settings key, its values and how to read/write them with Drush; the visibility
  rules; the `?bootstrap=no` escape hatch** → [configure/settings.md](configure/settings.md)
- **The four library ids, where the files must live, and the CDN mechanism** →
  [theming/libraries.md](theming/libraries.md)

Quick facts:

| Thing | Value |
|---|---|
| Config object | `bootstrap_library.settings` |
| Configure route / path | `bootstrap_library.admin` → `/admin/config/development/bootstrap_library` |
| Permission | `administer site configuration` (core's) |
| Menu link | under *Configuration → Development* |
| Libraries | `bootstrap_library/bootstrap` (minified), `…/bootstrap-dev` (source), `…/bootstrap-composer`, `…/bootstrap-cdn` (built at runtime) |
| Local file root | `/libraries/bootstrap/` (web root), `dist/` subdir for the composer variant |
| Hooks implemented | `hook_page_attachments()`, `hook_library_info_build()` |
| Composer dep | `twbs/bootstrap: *` |

Known quirks: `files.types` is stored but never read; the config **schema file is malformed**
(missing `mapping:` levels under `theme`/`url`/`minimized`/`cdn`/`files`), so
`drush config:inspect`-style validation will complain and the values are untyped.
