<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — magnify field formatter

## Enable
1. Ensure `image` and `jquery_ui` are enabled.
2. On an image field's **Manage display** (e.g. `admin/structure/types/manage/<type>/display`), choose the **Magnify Image Viewer** formatter.

## Settings (`MagnifyFieldFormatter`)
| Setting | Options | Notes |
| --- | --- | --- |
| `image_style` | any image style / *None (original)* | Applied via `ImageStyle::buildUrl()`; else original file URL. |
| `size` | `90`, `100`, `150`, `250`, `300` | Loupe size in px. |
| `zoom` | `1`–`5` | Zoom scale level. |

## Rendering
- Builds `#theme => 'magnify'` with `url` (fid → uri/alt/title), `size`, `zoom`.
- Attaches library `magnify/magnify`.
- Only acts when the active formatter is `magnify_field_formatter` (`isMagnifyDisplay()`).

## Supply-chain / production note
`magnify.libraries.yml` loads JS from `cdn.jsdelivr.net/gh/ninjadrupal/magnifyjs@1.0.0/...`. The reference **is version-pinned** (`@1.0.0`), which is safer than an unpinned branch ref, but it is still code fetched from a third-party host at page load. For production, vendor the asset locally and point the library at the local file.
