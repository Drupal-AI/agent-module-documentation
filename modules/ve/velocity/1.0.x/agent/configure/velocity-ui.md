<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — Velocity UI

Enable the `velocity_ui` submodule to get a configuration UI; while it is enabled
the base module stops attaching Velocity automatically.

## Settings form
Route `velocity.settings` → `/admin/config/user-interface/velocity/settings`
(`velocity_ui\Form\VelocitySettings`, `ConfigFormBase`), permission
`administer velocity`. Writes the `velocity.settings` config object:

| Key | Meaning |
|-----|---------|
| `load` | Master on/off for auto-attaching the library |
| `pack` | Also attach the Velocity UI transition pack |
| `version` | `v1` (1.5.2) or `v2` (2.0.6) |
| `method` | `local` or `cdn` (falls back to CDN if local lib missing) |
| `minimized.options` | `1` minified (production) / `0` non-minified (dev) |
| `url.visibility` | `0` = all pages except listed, `1` = only listed |
| `url.pages` | one path glob per line (`*` wildcard, `<front>`) |

Saving flushes all caches so the new attachment logic takes effect.

## Attachment behaviour
`velocity_ui_page_attachments()` reads the config and attaches
`velocity/velocity(-cdn)-<version><variant>js` (and the `.ui` pack when `pack`
is set). `_velocity_ui_check_url()` matches the current path against `url.pages`
and also short-circuits when the request has `?velocity=no`.

## Manual use
To animate a specific component instead of site-wide, leave `load` off (or
disable `velocity_ui`) and attach the library from your render array:
`$build['#attached']['library'][] = 'velocity/velocity-v2.min.js';`
