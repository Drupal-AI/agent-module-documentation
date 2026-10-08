<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# imageshop — configuration & operation

## Settings form (`/admin/config/media/imageshop`, `SettingsForm`)
Saves to config object `imageshop.settings`:
- `token` (textfield, required) — Imageshop permanent token.
- `private_key` (textfield) — Imageshop private key.
- `hide_media_browser` (checkbox) — hide the Drupal media library for Imageshop media types.
- `enabled_media_types` (checkboxes) — media types that swap the core upload for the Imageshop browser.
- `imageshop_browser_settings` (fieldset): `interface_name`, `Language`/culture (`nb-NO`|`en-US`), `show_size_dialog`, `show_crop_dialog`, `free_crop`, `insert_immediately` (stored as string `'true'`/`'false'`).

## Token flow (`TokenService`)
`getTemporaryToken()` returns a cached `ImageShopTempToken` from state key `imageshop:token_state_key` if not expired (24h), else `regenerateToken()` calls
`GET https://webservices.imageshop.no/V4.asmx/GetTemporaryToken?token=…&privateKey=…` (HTTPS), parses the XML body, and re-caches. `hook_cron` calls `regenerateToken()`.

## Iframe (`ImageshopController::build`, route `imageshop.iframe`)
Renders `imageshop_iframe` theme with drupalSettings `imageShop.baseUrl = https://client.imageshop.no/InsertImage2.aspx?IFRAMEINSERT=true&` plus a query string carrying the temp token and browser settings. `#cache max-age = 0`. Alterable via `hook_imageshop_iframe_render_alter()`.

## Editor integration
`imageshop_form_media_library_add_form_upload_alter()` swaps the managed-file `#process` / `#type` to `imageshop` for enabled media types; `ImageShopWidget` (field widget) and `ImageShopElement` drive selection back into Drupal.

## Known issues
- Reconcile the settings-route permission (`administer imageshop`) with the defined `administer imageshop configuration`.
