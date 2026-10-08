<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — icm field formatter

## Enable
1. Ensure `image` and `jquery_ui` are enabled.
2. On an image field's **Manage display** (e.g. `admin/structure/types/manage/<type>/display`), choose the **Image Compare Viewer** formatter.
3. Set the image field's *Allowed number of values* to 2+ so there are images to compare.

## Settings (`IcmFieldFormatter`)
| Setting | Options | Notes |
| --- | --- | --- |
| `image_style` | any image style / *None (original)* | Applied via `ImageStyle::buildUrl()`; else original file URL. |
| `effects` | `horizontal`, `vertical`, `45deg` | Slider orientation. |
| `icm_link_image_to` | `""` (nothing), `content`, `file` | Wraps images in an `onclick` open to node canonical or the file URL. |

## Rendering
- Builds `#theme => 'icm'` with `url` (fid → uri/alt/title), `effect`, and `link_image_to`.
- Attaches library `icm/icm`.
- Only acts when the active formatter is `icm_field_formatter` (`isIcmDisplay()`).

## Supply-chain / production note
`icm.libraries.yml` pulls JS/CSS from `cdn.jsdelivr.net/gh/ninjadrupal/icm/src/min/...` with **no version or commit pin** (serves the GitHub repo's current default branch). For production, download and vendor these assets (or pin to a commit) and point the library at local files, so a change to the upstream repo cannot inject arbitrary JS into your pages.
