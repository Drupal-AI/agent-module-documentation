<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor 5 button, AJAX controller & AI service

## Pieces

- **CKEditor 5 plugin** — `aidmi.ckeditor5.yml` registers plugin `aidmiPlugin.AIDmi` with toolbar
  item `aidmi` (label *"AI, describe my image!"*), library `aidmi/aidmi_ckeditor`, admin library
  `aidmi/admin.aidmi`, `elements: false` (it edits attributes, contributes no new tags). Source in
  `js/ckeditor5_plugins/aidmiPlugin/src/` (`index.js`, `aidmi.js`, `aidmiui.js`); built bundle
  `js/build/aidmiPlugin.js` (webpack; `npm install && npm run build`).
- **Runtime JS** — `aidmi/aidmi_ckeditor` library loads `js/aidmi.ckeditor.js` (buttons + AJAX)
  and `js/aidmi.dialog.js` (review dialog), plus `core/ckeditor5`, `core/drupal.dialog.ajax`,
  `core/jquery`, `core/once`.
- **Service** `aidmi.ai_service` = `Drupal\aidmi\Service\AidmiAiService` (args `@config.factory`,
  `@ai.provider`).
- **Controller** `aidmi.aidmicontroller` = `Drupal\aidmi\Controller\AidmiController`
  (arg `@aidmi.ai_service`; note the wired `@request_stack` is unused — the class reads
  `\Drupal::request()` directly).

## Two entry points

1. **Per-image (sidebar) button** — `Drupal.behaviors.ckeditorImageUploadMonitor` watches the DOM
   (MutationObserver) for CKEditor's alt-text field appearing; `Drupal.aidmi.aidmiButton()` injects
   an AIDmi button next to it. Clicking calls `Drupal.aidmi.aidmiAjax(uuid)` which POSTs the editor
   body as `content` to **`/admin/aidmi/describe-image-ajax/{file_uuid}`**.
2. **Toolbar button (bulk)** — the CKEditor toolbar item collects every `<img>`/`drupal-media`
   UUID in the body and POSTs `content` + `imagesJSON` to
   **`/admin/aidmi/describe-content-ajax`** (route `aidmi.describe_content_ajax`).

Both routes require the **`generate aidmi accessibility`** permission and return `_format: json`.
(The image route also declares a `fid: \d+` requirement, but the path parameter is `{file_uuid}`,
so that constraint matches no parameter and has no effect.)

## Controller (`AidmiController`)

- `analyzeImageAjax($file_uuid)` — loads a file entity by UUID
  (`entityTypeManager->getStorage('file')->loadByProperties(['uuid' => $file_uuid])`), reads the
  physical bytes (`file_get_contents(realpath)`), base64-encodes them, and calls
  `AidmiAiService::analyzeImage($image_data, $mime_type)`. Returns
  `{success: true, alt: <cleaned model output>}`. Errors are caught, logged to the `aidmi` channel,
  and returned as `{success: false, error: ...}` with HTTP 200.
- `analyzeContentAjax()` — reads `content` and `imagesJSON` from the request, calls
  `AidmiAiService::analyzeContent($content, $imagesJSON)`, `json_decode`s the result and returns the
  array to JS. Same catch/log/200 error convention.

## Service (`AidmiAiService`)

- `getEngine()` — resolves the provider/model. If `ai_model` is set,
  `loadProviderFromSimpleOption()` / `getModelNameFromSimpleOption()`; otherwise
  `getDefaultProviderForOperationType('chat_with_image_vision')`. Returns `NULL` if none, which the
  callers turn into an exception.
- `analyzeImage($base64, $mime, $content='', $uuid='')` — builds an `ImageFile`
  (`setBinary(base64_decode(...))`, mime, filename), constructs a strict prompt that embeds
  `api_instructions`, optionally appends `strip_tags`'d body context (with each embedded image
  replaced by an `[IMAGE LOCATED HERE - UUID: …]` marker via `preg_replace_callback`), and demands a
  JSON template `{alt:…}` (+ `{caption:…}` when `enable_captions`). Sends a single-message
  `ChatInput` to `provider->chat($input, $model_id)`, strips ```json fences, extracts the first
  `{…}` block, and returns that cleaned string.
- `analyzeContent($content, $imagesJSON)` — bulk path. `json_decode`s `imagesJSON` (array of
  `{data-entity-uuid, type}`), resolves each to a file via `getFileIdByUuid()`, attaches each image
  (`ImageFile::setBinary(file_get_contents(realpath))`), builds a numbered JSON template
  (`IMAGE_0`, `IMAGE_1`, …), sends one multi-image `ChatInput`, then runs a **re-mapping pipeline**
  (`json_decode` + three matching strategies: by `image_id`, by associative root key, by linear
  position) to align model output back to the original UUIDs. Returns
  `[{images:[{data-entity-uuid, src, alt, caption, recommendation, recommendation_caption}, …]}]`.
- `getFileIdByUuid($uuid, $type)` / `loadMediaByUuid($uuid)` — for `type == 'drupal-media'` loads
  the media by UUID and returns its `field_media_image` file; otherwise loads a file entity by UUID.

## Review dialog & write-back (`aidmi.dialog.js`)

`Drupal.aidmi.aidmiDialog(data, callback)` builds a modal (`Drupal.dialog`) with the image preview,
alt-text radios (AI-suggested vs decorative), editable alt textarea, and — when captions are enabled
— caption radios + textarea. On *Insert Text*, `localCollectSelections()` reads the chosen values
and `localModifyImagesInContent()` writes them back into the CKEditor data: it sets `alt` (empty +
`role="presentation"` when decorative) and, for captions, sets `data-caption` and inserts/updates a
`<figcaption>` inside the enclosing `<figure>`, then `editor.setData(...)`.

## Operating notes

- The pipeline never persists anything server-side: it reads managed files, calls the model, and
  returns suggestions; the editor writes chosen values into content only when the author saves the
  node.
- All model I/O goes through the AI module provider (`provider->chat()`) — there is no direct HTTP
  client, no external URL fetch, and no credential handling in this module; TLS and key storage are
  the AI/Key modules' responsibility.
- Model output is untrusted free text; it is inserted into the editor as an `alt` attribute /
  `figcaption` for the author to review before save (it is not auto-published), and passes through
  the text format's filters on render.
