<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Single Page Importer — import pipeline & field mapping

## Entry point
`ai_single_page_importer_import_callback(array &$form, FormStateInterface $form_state): AjaxResponse` (`ai_single_page_importer.module`). Steps, in order:
1. Read `source_url` from form state; empty → error message.
2. Flood check (`flood_limit`/`flood_window`, identifier `uid-clientIp`).
3. `UrlValidator::validate($url)` — returns `['valid' => bool, 'error' => string]`.
4. `flood()->register(...)`.
5. Load field definitions for the current node bundle (`entity_field.manager`).
6. `AiContentExtractor::extractContent($url, $bundle, $field_definitions)`.
7. On `['error' => …]`, sanitize (strip file paths, genericize api/key messages) and show it; otherwise send `PopulateFieldsCommand($content)` + a success message.

## UrlValidator (`src/Service/UrlValidator.php`)
`validate()`:
- `filter_var($url, FILTER_VALIDATE_URL)` and `parse_url()` sanity.
- Scheme must be `http`/`https`.
- If `host` is a literal IP: reject when `FILTER_VALIDATE_IP` with `FILTER_FLAG_NO_PRIV_RANGE | FILTER_FLAG_NO_RES_RANGE` fails (blocks literal private/reserved IPs).
- Domain blacklist match via `matchesDomain()` (wildcards → regex).

## AiContentExtractor (`src/Service/AiContentExtractor.php`)
- `extractContent()` — Guzzle `GET` with `User-Agent`, `timeout` (config), `allow_redirects => ['max' => 3, 'strict' => TRUE]`. Rejects bodies > 10 MB. Calls `cleanHtml()`.
- `cleanHtml()` — `DOMDocument::loadHTML(mb_convert_encoding(...,'HTML-ENTITIES','UTF-8'))`, removes `script/style/nav/footer/header/aside`, extracts `textContent`, normalizes whitespace, truncates to `max_content_length`.
- `analyzeFields()` — walks field definitions; keeps `body` + `field_*`; categorizes:
  - `text_long`, `text_with_summary` → `long_text`
  - `string`, `text` → `short_text`
  - `entity_reference` to `taxonomy_term` → `taxonomy`
  - `datetime`, `daterange`, `timestamp` → `date`
  - `link` → `link`
  - fires `hook_ai_single_page_importer_field_map_alter(&$field_map, $field_definitions)`.
- `extractWithAi()` — reads chat provider/model from `ai.settings`, `aiProvider->createInstance($provider)`, builds a prompt from `buildFieldRequirements()`, calls `$provider->chat([...], $model, ['ai_single_page_importer'])`, strips ```` ```json ```` fences, `json_decode`, then `sanitizeExtractedContent()`. Adds `_field_map` and `_bundle` metadata keys to the result.
- `sanitizeExtractedContent()` — `long_text` → `HtmlSanitizer::sanitize()`; `short_text` → `strip_tags()`; `taxonomy` → `array_map('strip_tags')` + trim.

## HtmlSanitizer (`src/Service/HtmlSanitizer.php`)
`sanitize()` allows a fixed tag set (`p,br,strong,em,u,b,i,h1–h6,ul,ol,li,blockquote,pre,code,a,img,table…`) with a small attribute allowlist. Uses HTMLPurifier when the class exists; otherwise falls back to `strip_tags($html, $allowed)` plus `removeUnsafeAttributes()` (regex-strips `on*=` handlers and `javascript:` in href/src).

## Client population (`src/Ajax/PopulateFieldsCommand.php` + `js/ai-single-page-importer.js`)
`PopulateFieldsCommand::render()` emits `{command: 'populateNodeFields', content}`. `Drupal.AjaxCommands.prototype.populateNodeFields` reads `content._field_map` / `content._bundle`, sets `title`, then per field category writes the value: `long_text`/`short_text` via `setFieldContent()` (CKEditor5 `setData()` if the field has `data-ckeditor5-id`, else `field.value`); `taxonomy` joins terms into the autocomplete input; `date`/`link` set `.value`. The editor reviews and saves manually.

## Extending field support
Implement `hook_ai_single_page_importer_field_map_alter(array &$field_map, array $field_definitions)` in a custom module to add mappings for custom field types or override a field's `category` (`long_text`, `short_text`, `taxonomy`, `date`, `link`, or a custom category your prompt logic handles).
