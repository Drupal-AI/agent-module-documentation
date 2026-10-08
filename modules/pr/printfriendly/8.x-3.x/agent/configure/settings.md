<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PrintFriendly & PDF — configuration

## Route & permissions
- Settings form: route `printfriendly.config` → `/admin/config/printfriendly/config` (menu link under `system.admin_config`). Permission: `administer printfriendly`.
- To see the rendered button, a user needs permission `access printfriendly`.
- Config object: `printfriendly.settings`. No `config/schema`, no default config file — the object is created on first save (`ddev drush config:get printfriendly.settings` errors until the form is saved once).

There is **no API key**. The free integration works as-is; PrintFriendly Pro (paid, on their side) is only recommended for paywalled or JS-rendered sites.

## Config keys (`printfriendly.settings`)
Set by `PrintfriendlyConfigForm::submitForm()`; read by `printfriendly.module`.

| Key | Values / default | Meaning |
|---|---|---|
| `printfriendly_display` | array of node-type machine names + `teaser` | Which content types show the button; `teaser` toggles the button in teaser view |
| `printfriendly_image` | preset filename or `custom-button-img-url` (default `print-button.png`) | Chosen button image (presets served from `//cdn.printfriendly.com/buttons|icons/<file>`) |
| `custom_button_img_url` | URL string | Button image URL, used only when `printfriendly_image == custom-button-img-url` |
| `printfriendly_page_header` | `default_logo` \| `custom_logo` | Header shown in printed/PDF output |
| `printfriendly_page_custom_header` | URL string | Custom header image URL → JS `pfHeaderImgUrl` |
| `printfriendly_tagline` | string | Header tagline → JS `pfHeaderTagline` |
| `printfriendly_click_delete` | `0` allow / `1` not allow | Reader click-to-delete → JS `pfdisableClickToDel` |
| `printfriendly_images` | `0` include / `1` exclude | Keep or drop images in output → JS `pfHideImages` |
| `printfriendly_image_style` | `right`\|`left`\|`none`\|`block` (default `right`) | Image alignment → JS `pfImageDisplayStyle` |
| `printfriendly_email` | `0` allow / `1` not allow | Email option → JS `pfDisableEmail` |
| `printfriendly_pdf` | `0` allow / `1` not allow | PDF option → JS `pfDisablePDF` |
| `printfriendly_print` | `0` allow / `1` not allow | Print option → JS `pfDisablePrint` |
| `printfriendly_custom_css` | URL string | Custom print CSS URL → JS `pfCustomCSS` |
| `db_version` | int (internal) | Set to `1` by `printfriendly_upgrade_db()` after legacy image migration |

## How the button and service are attached
- `printfriendly_page_attachments()` (runs every request): calls `printfriendly_upgrade_db()`, then adds an inline `<script>` to `html_head` that declares the `pf*` JS variables above and appends `//cdn.printfriendly.com/printfriendly.js`; also attaches library `printfriendly/printfriendly-libraries` (the module's `css/printfriendly.css`). `pfPlatform` is hard-coded to `'Drupal 8'`.
- `printfriendly_node_view()`: for a node whose type is in `printfriendly_display` and when the current user has `access printfriendly`, appends `build['printfriendly']` with the button markup. Teaser view is included only if `teaser` is also selected.
- `printfriendly_create_button($url = NULL, $popup = TRUE)`: builds the `<a href="https://www.printfriendly.com/print?url=<absolute current URL + query>">` anchor wrapping the chosen `<img>`. Node buttons use the current page URL; the popup variant adds `onclick="window.print(); return false;"`.

## Block placement
Block plugin id `block_printfriendly` (admin label "printfriendly") in `src/Plugin/Block/PrintfriendlyBlock.php` returns `printfriendly_create_button()`. Place it via Block layout (`/admin/structure/block`) to show the button outside node views. Block visibility/placement is controlled by core block config, not this module.
