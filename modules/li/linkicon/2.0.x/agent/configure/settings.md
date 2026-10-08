<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Global settings, icon-font CSS, route & permission

## Settings form

- Route: **`linkicon.settings`** → `/admin/config/user-interface/linkicon`
  (`LinkIconSettingsForm`, a `ConfigFormBase`).
- Menu link under *Configuration › User interface*.
- Permission required: **`administer linkicon`** (marked `restrict access: true`).

The form has exactly **one** field:

- **Icon font CSS file path** → config `linkicon.settings:font`. A valid path to a CSS file, or a
  comma-separated list for several, e.g. `/libraries/fontello/css/fontello.css, /libraries/fontello/css/other.css`.
  Leave empty if the theme already loads the icon font, or if using the FontAwesome (5+) module
  with SVG+JS.

On submit the form also clears the library-discovery cache so the new font stylesheet is picked up
(the path is exposed via `hook_library_info_build` in `LinkIconManager::libraryInfoBuild()`).

## Config object

`linkicon.settings` (config schema `linkicon.settings`, type `config_object`):

```yaml
font: '/libraries/fontello/css/fontello.css'
```

There is **no `config/install` default**, so on a fresh enable `font` is unset (null/empty).

Read/write with drush:

```bash
drush cget linkicon.settings font
drush cset linkicon.settings font '/libraries/fontello/css/fontello.css' -y
```

The module is icon-library agnostic: this path just loads a stylesheet; the actual icon classes
come from the `linkicon_prefix` + predefined key (see [formatter.md](formatter.md)).
