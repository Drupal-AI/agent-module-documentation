<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Brandfolder (brandfolder) — agent index

Deep integration with the **Brandfolder Digital Asset Management (DAM)** platform. Editors browse
Brandfolder assets and Drupal creates `file`/`media` entities on demand; images are served and
image-styled directly from the Brandfolder Smart CDN. Version **6.1.0**, core `^10 || ^11`, PHP 8.1+.

## Dependencies
- Core `media` and contrib `key` (both required in `brandfolder.info.yml`).
- Composer libs: `brandfolder/brandfolder-sdk-php:4.x-dev` (the API client) and `drupal/key:^1.0`.
- Uses core Media Library / optionally the contrib Entity Browser module.

## What it provides
- **Media source** `brandfolder_image` — `src/Plugin/media/Source/BrandfolderImage.php`.
- **Image toolkit** `brandfolder` (+ operations Convert/Crop/Resize/Scale/ScaleAndCrop) — `src/Plugin/ImageToolkit/`.
- **Stream wrapper** scheme `bf://` — `src/StreamWrapper/BrandfolderStreamWrapper.php` (base `https://cdn.bfldr.com`).
- **Image factory** override + **MIME-type guesser** (`file.mime_type.guesser.brandfolder`, priority 100).
- **Field widgets** `brandfolder_entity_browser_file`, image browser widget; **Entity Browser widget** `brandfolder_browser`.
- **Services** `brandfolder.key_service` (Key-module API-key lookup), `brandfolder.gatekeeper` (asset access/fetch), `brandfolder.webhook_event_subscriber`, `brandfolder.webhook_access_check`.
- **Event** `BrandfolderWebhookEvent`; **AJAX command** `BrandfolderSetAltTextCommand`.
- **Config** `brandfolder.settings` (schema in `config/schema/brandfolder.schema.yml`).
- **DB table** `brandfolder_file` (fid ↔ bf_attachment_id ↔ bf_asset_id ↔ cdn_id ↔ uri), `brandfolder.install`.
- **Global helper** `brandfolder_api($key_type)` in `brandfolder.module` → returns a `BrandfolderClient`.

## Routes (`brandfolder.routing.yml`)
- `brandfolder.brandfolder_settings_form` — `/admin/config/media/brandfolder` (`administer brandfolder settings`).
- `brandfolder.browser_update` — `/brandfolder-browser-update` (`read brandfolder assets`), asset search JSON.
- `brandfolder.browser_get_attachments` — `/brandfolder-browser-get-attachments` (`read brandfolder assets`).
- `brandfolder.webhook_listener` — `/brandfolder-webhook-listener` (custom `_brandfolder_webhook_access_check`).

## Permissions (`brandfolder.permissions.yml`, all `restrict access: TRUE`)
`administer brandfolder settings`, `read brandfolder assets`, `create brandfolder assets`.

## Solution docs
- [Configuration & settings](config/settings.md)
- [Media source, browser & fields](plugins/media-source-and-browser.md)
- [Image toolkit & CDN stream wrapper](plugins/image-toolkit-cdn.md)
- [API client, services & webhook](api/client-and-webhook.md)
