<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How it translates (mechanism)

`GoogleTranslator` talks to Google's **Translate API v2**
(`https://www.googleapis.com/language/translate/v2`) over the core `http_client` (Guzzle), using the
`tmgmt.data` helper to flatten/unflatten job data. Supported actions: `translate`, `languages`,
`detect`.

## Job flow

- `requestTranslation($job)` → `requestJobItemsTranslation($job->getItems())`, then marks the job
  submitted (unless rejected). For continuous jobs each item is set active first.
- `requestJobItemsTranslation()`:
  1. `tmgmt.data->filterTranslatable()` flattens the item's data to `#text` strings, preserving keys.
  2. Source strings are batched with `array_chunk($q, 5)` (**qChunkSize = 5**) and each chunk is sent
     via `googleRequestTranslation()` with `source` = job remote source language, `target` = job
     remote target language, and `q` = the chunk.
  3. Returned `data.translations[].translatedText` are HTML-entity-decoded and mapped back onto the
     original keys, then `unflatten()`ed and saved with `$job_item->addTranslatedData()`.
  4. On a `TMGMTException` the whole job is `rejected()` with the error message.

## Requests

`doRequest($translator, $action, $request_query, $options)` builds the URL as
`<translatorUrl>/<action-suffix>` (POST), attaches the API key, and returns the decoded JSON. A
`BadResponseException` is turned into a `TMGMTException` carrying Google's `error.message`.

## Languages & detection

- `getSupportedRemoteLanguages($translator)` — returns Google's language list (empty without an
  `api_key`); results are cached on the plugin.
- `getSupportedTargetLanguages()` / `getSupportedLanguagePairs()` build on that list.
- Detection uses the `detect` action.

## Extension points

There is **no** custom hook or event. To change behavior you subclass the plugin or configure the
translator entity. Two test-only setters exist (`setTranslatorURL()`, `setQParamName()`) to point the
plugin at a mock endpoint and avoid Drupal's `q` query-param collision — production code should not
need them.
