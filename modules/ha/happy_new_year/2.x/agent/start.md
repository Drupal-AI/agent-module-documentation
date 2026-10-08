<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Happy New Year! (happy_new_year) — agent index

Site-wide festive decoration: an animated **garland** strip and/or falling **snow** attached to
every non-admin page, optionally only during a December–January date window. Version 2.0.4
(doc dir `2.x`). Core `^10 || ^11`. License GPL-2.0-or-later. **No** dependencies on other
Drupal modules, **no** entities, blocks, services, plugins, permissions of its own, or Drush.

## What it actually is (from source)

- One admin **settings form**: `HnySettingsForm` (`src/Form/HnySettingsForm.php`, a
  `ConfigFormBase`), form id `happy_new_year_settings`, editing config `happy_new_year.settings`.
  Route `happy_new_year.happy_new_year_admin_settings` → `/admin/config/media/happy_new_year`,
  requirement `_permission: 'administer site configuration'` (a core permission — module defines
  no `*.permissions.yml`). Menu link under *Configuration → Media* (`links.menu.yml`).
- One **`hook_page_attachments()`** in `happy_new_year.module`: on non-admin routes it reads
  `happy_new_year.settings` and attaches the garland/snow asset libraries + `drupalSettings`.
- Helper `_happy_new_year_isholidaytime()` gates the effect to the configured Dec/Jan window
  when the "working period" is enabled.
- Asset libraries (`happy_new_year.libraries.yml`): `garland`, `snow`, `settings-form`,
  `colorpicker`, and four **Snowstorm** variants (`snowstorm`, `snowstorm-min`, `snowstorm-cdn`,
  `snowstorm-min-cdn`). JS: `js/garland.js`, `js/snow.js`, `js/colorpicker.js` (Farbtastic wheel).
- `happy_new_year.install`: three `hook_update_N` (reset config; notice; default CDN on).
- **No** config schema dir, **no** submodules, **no** `modules/` subdir.

## Solution docs

- **Install, the settings form, every config key, and the page-attachment mechanism** →
  [config/settings.md](config/settings.md)
