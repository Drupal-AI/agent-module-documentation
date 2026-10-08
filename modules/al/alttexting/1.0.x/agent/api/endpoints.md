<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alttext.ing generation flow, routes, service & queue

## Two ways alt text gets generated

1. **Manual button** — `Hook\AlttextingHooks::fieldWidgetSingleElementFormAlter()` attaches the
   `alttexting/alt-text-generator` library and, for `ImageWidget` fields with an existing file, renders
   the `alttexting_button` theme (`templates/alttexting-button.html.twig`). `js/alt-text-generator.js`
   POSTs `{fid, langcode}` to `alttexting.generate_async`, then polls `alttexting.try_get_result` and
   fills the alt `<input>` on success. The button only appears when `api_key` is configured.

2. **Auto on save** — `hook_media_insert` / `hook_media_update` (`alttexting.module` legacy shims →
   `AlttextingHooks::mediaInsert/mediaUpdate`) call `alttexting_media_processor($media)`. That function
   (in `alttexting.module`) no-ops unless `api_key` set AND `autogenerate_on_save` TRUE; processes only
   the `image` bundle's source field; skips when alt is already non-empty. Then either enqueues an item
   (`autogenerate_use_queue` TRUE) or calls `generateAsync()` directly (FALSE) which registers a webhook.

## Routes (`alttexting.routing.yml`)

| Route | Path | Method | Access | Controller |
|---|---|---|---|---|
| `alttexting.generate_async` | `/alttexting/generate-async` | POST | `_role: authenticated` | `AltTextController::generateAsync` |
| `alttexting.try_get_result` | `/alttexting/try-get-result` | GET | `_role: authenticated` | `AltTextController::tryGetResult` |
| `alttexting.settings` | `/admin/config/media/alttexting` | — | `_permission: administer alttexting settings` | `Form\AltTextSettingsForm` |
| `alttexting.webhook` | `/alttexting/webhook` | (any) | `_permission: access content` | `WebhookController::process` |

- `AltTextController::generateAsync()` reads `fid` (numeric) + `langcode` from the POST body, calls
  `AltTextGeneratorService::generateAsync((int)$fid, $langcode)`, returns `{id}` (the operation id).
- `AltTextController::tryGetResult()` reads `id` from the query and proxies the service's poll,
  returning the service JSON (`{hasAnswer, altText, error, ...}`).
- `WebhookController::process()` reads `media_id`, `langcode`, `image_field` from the query and
  `AltText` / `Error` from the request body, then calls `AltTextGeneratorService::saveAltText()`.

## Service: `Service\AltTextGeneratorService` (`alttexting.alttext_generator`)
Constructed with config.factory, `http_client` (Guzzle), entity_type.manager, language_manager,
logger.factory, file_url_generator, url_generator.

- `generateAsync(int $fid, string $langcode, ?int $media_id, ?string $image_field): array` — resolves
  the image via `getImageUrlFromFid()`, builds body `{imageUrl, lang (language name), apiKey}`, and when
  called from the sync auto-save path (media_id + image_field present, queue off) adds a `webhook` URL
  built from route `alttexting.webhook` with `media_id/langcode/image_field` as query args. POSTs JSON to
  `{api_url}/generate-async` and returns the decoded response. Throws `\Exception` on Guzzle failure.
- `getImageUrlFromFid(int $fid): ?string` — loads the `file` entity, builds/creates the `alttexting`
  image-style derivative; if `encode_image` returns a base64 `data:` URI of the derivative bytes,
  otherwise the absolute URL of the styled file.
- `tryGetResult(string $id): JsonResponse` — GET `{api_url}/try-get-result?id=…` (30s timeout),
  returns the decoded body as JSON, or a 500 JsonResponse on error / missing `api_url`.
- `saveAltText(int $media_id, string $langcode, string $image_field, string $alt_text): void` — loads
  the media (correct translation), validates the field, **skips if alt already set**, sets `alt` and
  saves. Logs at each step to the `alttexting` channel.

## Queue worker: `Plugin\QueueWorker\AltTextQueueWorker` (`alttexting_media_processor`)
`@QueueWorker(cron={"time"=60})`. `processItem()` expects `{media_id, fid, langcode, image_field}`,
calls `generateAsync()`, then `pollForResult()` (up to `MAX_RETRIES=10`, `RETRY_DELAY=3`s, sleeping
between attempts) calling `tryGetResult()` until `altText` is present, then `saveAltText()`. Re-throws
on error so the item is retried. Created/deleted by `hook_install`/`hook_uninstall`.

## Front-end library
`alttexting/alt-text-generator` (`alttexting.libraries.yml`) → `js/alt-text-generator.js` +
`css/alt-text-generator.css`, deps `core/jquery`, `core/drupal`, `core/once`. Polls up to 20 times at
3s intervals; endpoint URLs are injected via `drupalSettings.alttexting.endpoints`.
