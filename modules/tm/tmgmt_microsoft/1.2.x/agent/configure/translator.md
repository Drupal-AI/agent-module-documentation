<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the Microsoft translator

## Create the provider

1. Go to **Translation › Providers** (`admin/tmgmt/translators`,
   route `entity.tmgmt_translator.collection`) and add a translator.
2. Choose plugin **Microsoft**.
3. Enter the **Microsoft Azure API Key** (`api_key`, required) — an Azure Cognitive Services
   Translator subscription key.
4. Click **Connect** to validate (the UI calls `getToken($api_key)`; an invalid key surfaces
   *"The 'Azure API Key' is not valid."*).
5. Optionally enable TMGMT's **auto accept** so returned translations are accepted automatically.
6. Save. The provider is now selectable when creating TMGMT jobs.

## Settings & schema

`tmgmt.translator.settings.microsoft`:

| Key | Type | Meaning |
|---|---|---|
| `api_key` | string | Azure Translator subscription key (required) |
| `auto_accept` | bool | Auto-accept translations (TMGMT standard option) |

The API key is stored in the translator entity's `settings`. (Like any Drupal config value it can be
overridden per-environment via `settings.php` `$config['tmgmt.translator.<id>']['settings']['api_key']`
or supplied from an environment variable if you prefer not to persist it.)

## Endpoints (hardcoded defaults)

`defaultConfiguration()` sets, and merges over any config:
- `token url` = `https://api.cognitive.microsoft.com/sts/v1.0/issueToken/`
- `translate url` = `https://api.cognitive.microsofttranslator.com`

These are not exposed in the settings form (only `api_key` is). They can be overridden only through
the plugin `configuration` array programmatically.

## Request flow (`MicrosoftTranslator`)

- `getToken($api_key)` — POST to `token url` with header `Ocp-Apim-Subscription-Key: <api_key>`,
  returns a JWT (cached per key in-process).
- `doTranslateRequest()` — POST to `<translate url>/translate` with
  `Authorization: Bearer <jwt>`, query `textType=html&from=<src>&to=<dst>&api-version=3.0`, body a
  JSON array `[{"Text": "..."}]`. Uses the injected Guzzle `http_client`.
- `doLanguageRequest()` — GET `<translate url>/languages?api-version=3.0&scope=translation` to list
  supported target languages (`getSupportedRemoteLanguages()` / `getSupportedTargetLanguages()`).
- Language mapping: `getDefaultRemoteLanguagesMappings()` → `zh-hans`→`zh-CHS`, `zh-hant`→`zh-CHT`.
- Escaping: `escapeStart`/`escapeEnd` wrap untranslatable text in
  `<span class="notranslate">…</span>`; `checkTranslatable()` rejects any segment over 50,000 chars.
- `requestJobItemsTranslation()` flattens the job item's translatable data, translates each segment,
  and writes results back via `tmgmt.data`; failures call `$job->rejected(...)`.

No module permissions, no Drush commands, no plugin types to implement (it *is* a TMGMT translator
plugin — to add another provider, implement a TMGMT `@TranslatorPlugin`, not a plugin type here).
