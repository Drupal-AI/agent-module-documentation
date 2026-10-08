<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Generation service & pipeline

Service id `dynamic_image_generator.dynamic_image_generator_service` →
`src/Service/DynamicImageGeneratorService.php` (args: entity_type.manager, file_system,
logger.factory, config.factory, twig, renderer, token, http_client).

## Public methods

- `generatePosterImage($poster_entity_id, array $custom_tokens = [], $entity_id = NULL, bool $is_preview = FALSE)`
  — full pipeline; returns a public image URL (string) or NULL. Saves a `dynamic_image` media
  entity and, unless `$is_preview`, writes the file into the template's `target_field` on the node.
- `generatePreviewImage($poster_entity_id, array $custom_tokens = [])` — renders without saving;
  returns the raw provider URL.
- `resolveCustomTokensForNode($node)` — resolves the configured `custom_tokens` for the node's
  bundle into `[token_name => value]` (honours `reference_field` drill-down and `random`).

## Pipeline (inside `generatePosterImage`)

1. Load `poster_entity`; read `content_type`, `html`, `css`.
2. If an `$entity_id` node is given and its bundle matches, run Drupal token replacement on the
   HTML/CSS via `processTokens()` (`token->replace(..., ['clear'=>TRUE,'sanitize'=>FALSE])`) —
   substitutes `[node:title]`, `[node:body]`, `[node:field_*]`, etc.
3. Build `$context` = image tokens (`[image_N]` file URLs) + caller `$custom_tokens` + resolved
   custom tokens + `site_name`, `date`.
4. `replaceImageTokens()` str-replaces `[image_*]` in the templates.
5. `renderTwigTemplate()` compiles the resulting HTML and CSS strings as Twig templates and
   renders them with `$context`.
6. `sanitizeContent()` normalises line endings/trim.
7. `callPosterGenerationApi($html, $css)` → provider (see below); returns an image URL or, for the
   built-in engine, an array carrying a File entity.
8. `createDynamicImageMedia()` downloads/attaches the image as a `dynamic_image` media entity
   (fields `field_dynamic_image`, `field_template_id`, `field_source_entity`); previews are
   flagged `field_is_preview_image`, unpublished, and their file set temporary.
9. Non-preview + a `target_field` → `reuseFileForTargetField()` writes the file/media into the
   node field and saves the node. Returns the media's public URL.

## Rendering providers (`callPosterGenerationApi`)

- `api_provider = htmlcsstoimage` (default): Guzzle `POST` to `api_endpoint`
  (`https://hcti.io/v1/image`) with `form_params` html/css/width/height, HTTP basic auth
  `[api_user_id, api_key]`, TLS verified (Guzzle default), retry (`retry_attempts`+1),
  timeout `request_timeout` (default 60). Returns `$result['url']`.
- `api_provider = inbuilt`: calls service `image_creating_engine.generator`
  (`InbuiltImageGenerator::generateImage`) which renders locally with `wkhtmltoimage`. Returns an
  array `{uri,file,url,...}` consumed directly (no download). See the submodule doc.

## Node-form auto-generation (`.module`)

- `dynamic_image_generator_form_node_form_alter()` — for each **active** template whose
  `content_type` matches the node and whose `target_field` exists on the node, adds a
  "Auto-generate Image" checkbox under a "Dynamic Image Generation" vertical tab, plus a live
  preview button. Qualifying template IDs are stashed in form state.
- `dynamic_image_generator_node_form_submit()` — for each ticked template, calls
  `generatePosterImage($poster_id, [], $node_id)` after the node is saved, then messages the
  editor. Failures are logged, not fatal.

## Preview controllers (`DynamicImageGeneratorController`)

- `previewWithCurrentData($poster_entity, $node, Request)` — route
  `dynamic_image_generator.preview_with_data`, permission `administer dynamic image generator`.
  Reads JSON `form_data`, builds node/sample tokens, calls `generatePosterImage(..., is_preview=TRUE)`
  or `generatePreviewImage()`, returns an `OpenModalDialogCommand` with the preview image.
- `getNodeTokens()` / `extractNodeFormData()` map a node's fields to tokens.
- `generatePoster()` (API route `dynamic_image_generator.generate_poster`) and several other
  controller methods (`selectContent`, `generateForNode`, `searchContent`,
  `getContentTypeFields`) are stubs returning `not implemented` / empty JSON in 1.1.2.
- `testChromeInstallation`, `testChromeDirect`, `testWkhtmlInstallation` render server
  diagnostics.

## Cron (`hook_cron`)

`dynamic_image_generator_cron()` deletes `dynamic_image` media flagged
`field_is_preview_image = 1` older than 24h (releasing file usage so core file_cron removes the
temporary files).

## Also present

- `src/DynamicImageManager.php` — a helper class for querying/cleaning `dynamic_image` media by
  template/entity. It is **not registered as a service** in `.services.yml` and references fields
  (`field_poster_id`, `field_entity_id_generated`, `field_poster_image`) that the module does not
  create, so it is effectively legacy/unused in 1.1.2.
- `src/` also contains several other classes (`BuiltinImageGeneratorService`,
  `DynamicGeneratorService`, `PosterGeneratorService`, and a second
  `src/DynamicImageGeneratorService.php` alongside the wired `src/Service/` one). None of these
  are registered in `.services.yml`; the only wired generation service is
  `Drupal\dynamic_image_generator\Service\DynamicImageGeneratorService` documented above. The
  gallery/example/overview pages are served by controllers referenced in `.routing.yml`
  (`DynamicImageGeneratorViewController`, `...ExampleController`, `...AdminController`).
