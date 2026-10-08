<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Ajax Loader

**Settings form:** `/admin/config/user-interface/ajax-loader`
**Route:** `ajax_loader.settings` (matches `configure:` in `ajax_loader.info.yml`)
**Menu:** Admin → Configuration → User interface → Ajax loader
**Permission:** `administer ajax loader`
**Config object:** `ajax_loader.settings` (schema type `config_entity`)

## Config keys

| Key | Type | Default | Meaning |
|---|---|---|---|
| `throbber` | string | `null` | Plugin ID of the active throbber. `null` = no custom throbber (core default used). |
| `hide_ajax_message` | boolean | `false` | Suppress the core "loading…" AJAX message. |
| `always_fullscreen` | boolean | `false` | Always render the throbber as a full-screen overlay. |
| `show_admin_paths` | boolean | `false` | Also show the throbber on admin routes (except the settings form itself). |
| `throbber_position` | string | `body` | CSS selector for the element the throbber is inserted into. |

Install defaults live in `config/install/ajax_loader.settings.yml`.

## The 12 built-in throbbers (`throbber` values)

| Plugin ID | Label |
|---|---|
| `throbber_pulse` | Pulse |
| `throbber_wave` | Wave |
| `throbber_circle` | Circle |
| `throbber_fading_circle` | Fading circle |
| `throbber_chasing_dots` | Chasing dots |
| `throbber_double_bounce` | Double bounce |
| `throbber_three_bounce` | Three bounce |
| `throbber_rotating_plane` | Rotating plane |
| `throbber_cube_grid` | Cube gird *(label typo is in the source)* |
| `throbber_folding_cube` | Folding cube |
| `throbber_wandering_cubes` | Wandering cubes |
| `throbber_swing` | Swing |

`throbber` is **required** on the form (a `<select>` built from
`ThrobberManager::getThrobberOptionList()`); `throbber_position` is also required (textfield,
default `body`).

## Set it with Drush

```bash
# Choose the Pulse throbber, place it in the body, hide the core message.
drush cset ajax_loader.settings throbber throbber_pulse -y
drush cset ajax_loader.settings throbber_position body -y
drush cset ajax_loader.settings hide_ajax_message true -y
drush cset ajax_loader.settings always_fullscreen false -y
drush cset ajax_loader.settings show_admin_paths false -y
drush cr    # required: libraries/markup are cached; the form calls drupal_flush_all_caches()
```

Read current values:

```bash
drush cget ajax_loader.settings
drush cget ajax_loader.settings throbber
```

## Notes

- After changing config, **clear caches** (`drush cr`). The settings form itself calls
  `drupal_flush_all_caches()` on submit because the chosen throbber's CSS is baked into the
  `ajax_loader.admin` / `ajax_loader.throbber` libraries via `hook_library_info_alter()`.
- The throbber only attaches on a page when `RouteIsApplicable()` returns TRUE: always on
  non-admin routes; on admin routes only when `show_admin_paths` is TRUE (and never on the
  `ajax_loader.settings` form route).
- Setting `throbber` to an unknown/empty value makes `hook_page_attachments()` skip
  attachment, effectively reverting to the core throbber.
