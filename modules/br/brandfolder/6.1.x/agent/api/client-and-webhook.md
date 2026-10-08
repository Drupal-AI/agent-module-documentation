<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Brandfolder — API client, services & webhook

## API client
The `brandfolder/brandfolder-sdk-php` package provides `Brandfolder\BrandfolderClient` (Guzzle-based). Get an
instance via the global helper `brandfolder_api(?string $key_type = 'guest', ?string $custom_api_key = NULL)`
(`brandfolder.module:47`): it resolves an API key through `BrandfolderKeyService`, reads `brandfolder_id` from
config, constructs the client, and enables verbose logging when `verbose_log_mode` is on. Endpoint is
`https://brandfolder.com/api/v4`; the key is sent as an `Authorization: Bearer …` header over HTTPS (default
Guzzle TLS verification). The SDK's `request()` method drives every call (`fetchAsset`, `listAssets`,
`listCustomFields`, etc.).

## Services (`brandfolder.services.yml`)
- `brandfolder.key_service` → `BrandfolderKeyService` — maps role → Key entity → key value (see
  [config/settings.md](../config/settings.md)).
- `brandfolder.gatekeeper` → `BrandfolderGatekeeper` — asset access/query layer (see
  [plugins/media-source-and-browser.md](../plugins/media-source-and-browser.md)).
- `stream_wrapper.brandfolder`, `image.factory` (override), `file.mime_type.guesser.brandfolder` — see
  [plugins/image-toolkit-cdn.md](../plugins/image-toolkit-cdn.md).
- `brandfolder.webhook_access_check` and `brandfolder.webhook_event_subscriber` — below.

## Webhook listener
Route `brandfolder.webhook_listener` → `POST /brandfolder-webhook-listener`
(`src/Controller/IncomingWebhookController.php`). Access is a custom check `_brandfolder_webhook_access_check`
(the controller implements `AccessInterface::access()`): it JSON-decodes the request body and allows the request
only when `data.attributes.event_type` is one of `asset.create` / `asset.update` / `asset.delete` and a non-empty
`data.attributes.key` string is present. `webhookListener()` then (optionally logs the payload under
`verbose_log_mode` and) dispatches a `BrandfolderWebhookEvent` named after the event type, returning HTTP 200
"Webhook handling complete."

### Event
`src/Event/BrandfolderWebhookEvent.php` — constants `ASSET_CREATE`/`ASSET_UPDATE`/`ASSET_DELETE`; carries
`$event->data` (the payload's `data`). Other modules may subscribe to these event names to react to Brandfolder
changes.

### Built-in subscriber
`src/EventSubscriber/WebhookEventSubscriber.php` subscribes only to `asset.update` → `assetUpdate()`. It reads the
asset key, calls `brandfolder_api()->fetchAsset()` (with attachments + custom fields), then performs one-way
metadata sync: re-maps merged attachments in `brandfolder_file`, populates missing image/file alt text from the
configured `alt_text_custom_field`, and re-saves media entities whose source is `BrandfolderImage` for
forcefully-updated metadata attributes. (The `asset.create` and `asset.delete` handlers are stubbed out.)

## Other hooks (`brandfolder.module`)
`brandfolder_field_info_alter()`, `brandfolder_form_alter()` / `brandfolder_form_field_config_edit_form_alter()`
(Image field → Brandfolder opt-in), `brandfolder_media_type_insert()`, `brandfolder_media_presave()` (metadata
sync on save), `brandfolder_file_delete()`, `brandfolder_views_pre_build()/pre_render()`, `brandfolder_theme()`
(browser + host-page templates), and `brandfolder_entity_embed_media_image_source_field_alter()`.
