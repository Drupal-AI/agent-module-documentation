<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Translate endpoint, access checker & translator service

## Route

`ckeditor5_deepl.routing.yml`:

```
ckeditor5_deepl.translate:
  path: '/api/ckeditor-deepl/translate'
  methods: [ POST ]
  defaults:
    _controller: '\Drupal\ckeditor5_deepl\Controller\TranslationEndpointController'
  requirements:
    _translate_access: 'TRUE'
```

POST-only. Access is the custom checker `_translate_access` (service
`access_check.ckeditor5_deepl.translate_access`, tagged `access_check applies_to: _translate_access`),
**not** a `_permission`.

## Access checker

`Access/TranslationEndpointAccessChecker::access()`:
1. Requires request header `Content-Type: application/json` (else forbidden).
2. `json_decode` the body; forbidden if empty or invalid JSON.
3. Symfony validator `Assert\Collection` on the payload: `text`, `format_id`, `target_langcode`
   required non-blank strings; `source_langcode`, `formality` optional strings; `allowExtraFields`
   TRUE, `allowMissingFields` FALSE.
4. Final gate: `AccessResult::allowed()` **iff**
   `$account->hasPermission('use text format ' . $payload['format_id'])` — i.e. the caller must be
   permitted to use the text format named **in the request body**. Otherwise forbidden.

Note: the declared permission `access deepl translate` (`.permissions.yml`) is **not referenced by
this route** — the effective gate is the per-format "use text format …" permission.

## Controller

`Controller/TranslationEndpointController::__invoke(Request)` → `translateRequest($payload)`:
- `loadEditorDeeplSettings($data->format_id)` loads the `editor` config entity for that format and
  returns `settings['plugins']['ckeditor5_deepl_integration']['deepl']`.
- Resolves the API key from that format's config: `DeeplKeys::loadApiKey($editor_settings['api_key'])`
  (`DeeplKeys` → `key.repository->getKey($id)->getKeyValue()`).
- Builds options from the **stored format config** (`split_sentences`, `preserve_formatting`,
  `tag_handling`); adds `formality` from the request only when the key is not a Free account
  (`DeeplTranslator::isAuthKeyFreeAccount`).
- Calls `DeeplTranslator::translate(...)` and returns the DeepL `TextResult` as a `JsonResponse`
  (HTTP 200). (There is a `@todo` for try/catch — DeepL exceptions are currently uncaught.)

## Translator service

`DeeplTranslator` (`ckeditor5_deepl.translator`) wraps `\DeepL\Translator` from `deeplcom/deepl-php`:
- `translate($api_key, $text, $source, $target, $options)` → `Translator::translateText(...)`.
- `isAuthKeyFreeAccount`, `getUsageStatistics` (used by the usage page and key validation),
  `getLanguages($type)` (source/target, via the first available `deepl_api_key`).
- The `\DeepL\Translator` is constructed with just the API key; the library performs its own HTTPS
  transport to `api.deepl.com` / `api-free.deepl.com`. This module does not alter TLS or the target host.

## Client-side flow

`js/ckeditor5_plugins/deeplIntegration/src/deeplIntegrationCommand.js` gathers the selected HTML
(`editor.data.stringify(...)`), the chosen `target_langcode`, the format id (from the editor
element's `data-editor-active-text-format`), and `options` from the plugin config, then calls
`deeplIntegrationApi.js::doRequest('api/ckeditor-deepl/translate', data)`. `getTranslation()` does a
`fetch` `POST` with `Content-Type: application/json`, `credentials: 'same-origin'`. The returned
`result.text` is fed back through `editor.data.processor.toView()` → `toModel()` →
`insertContent()`, so it is inserted through CKEditor's data pipeline (constrained to the format's
allowed elements) rather than as raw DOM.
