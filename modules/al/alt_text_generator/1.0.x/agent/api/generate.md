<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alt Text Generator — generate route, controller & widget flow

## Widget hook (where the button comes from)

`alt_text_generator_field_widget_single_element_form_alter(&$element, &$form_state, $context)` in
`alt_text_generator.module`:

1. Runs only when `$context['widget'] instanceof \Drupal\image\...\ImageWidget` and
   `$element['#alt_field']` is set (alt field enabled on the field).
2. Attaches library `alt_text_generator/alt_text_generator`.
3. Computes `lang` from the edited entity's language (or the site default) and pushes
   `drupalSettings.altTextGenerator = { lang, apiKey, defaultLanguage }`.
4. If an image is already uploaded (`$element['#default_value']['fids']`), adds a `#type => button`
   "Generate Alt Text" with class `alt-text-generator-button` and `data-file-id` = first fid.

## JS behavior

`js/alt_text_generator.js` (`Drupal.behaviors.altTextGenerator`): on button click it shows a
throbber, disables the alt input, and `$.ajax` **POSTs** `{ fid, language }` (language =
`drupalSettings.altTextGenerator.defaultLanguage`) to `Drupal.url('api/alt-text-generator/generate')`.
On success it strips wrapping quotes from `response.altText` and sets it as the value of the
sibling `input[name$='[alt]']`. On error it shows `response.error` (or a generic message) via
`Drupal.Message`. It also shows/hides the button as files are added via the managed-file AJAX.

## Route

`alt_text_generator.routing.yml`:

```yaml
alt_text_generator.generate:
  path: '/api/alt-text-generator/generate'
  defaults:
    _controller: '\Drupal\alt_text_generator\Controller\AltTextGeneratorController::generate'
  requirements:
    _permission: 'access content'
  methods: [POST]
  options:
    no_cache: TRUE
```

## Controller

`src/Controller/AltTextGeneratorController::generate(Request $request)`
(services injected: `http_client`, `file_system`, `config.factory`):

1. Reads `fid` and `language` from `$request->request` (the POST body).
2. `File::load($fid)` — 400 JSON error if missing/invalid.
3. Resolves `file_system->realpath($file->getFileUri())`; 400 if the file does not exist on disk.
4. Loads `api_key` from `alt_text_generator.settings`; 400 if unset.
5. Builds a `data:{mime};base64,{...}` URI from `file_get_contents($file_path)` +
   `mime_content_type()`.
6. `httpClient->post('https://alttextgeneratorai.com/api/drupal', ['json' => ['image' => $dataUri,
   'wpkey' => $apiKey, 'language' => $language]])` — Guzzle default TLS (verification on).
7. On HTTP 200 returns `JsonResponse(['success' => TRUE, 'altText' => $body])`; otherwise throws.
8. `GuzzleException` → logs to `alt_text_generator` channel, returns `{success:FALSE, error:'API
   error occurred.'}` with 500. Other `\Exception` → logs and returns the message with 400.

**Response handling:** `altText` is the vendor's raw response body, returned as JSON and injected
into an input **value** by the JS — never rendered as raw markup.

## Operating notes

- The endpoint is **POST-only** and marked `no_cache`. The image sent is a local managed file
  chosen by numeric `fid`; the module never fetches a remote/user-supplied URL.
- Errors and vendor failures are logged to the `alt_text_generator` logger channel — check
  Reports → Recent log messages when generation fails.
- Language sent to the API is the widget's `defaultLanguage` (the saved `default_language`
  setting), not necessarily the edited entity's own language.
