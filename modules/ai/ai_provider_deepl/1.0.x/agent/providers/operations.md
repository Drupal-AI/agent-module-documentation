<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Provider mechanism — ai_provider_deepl

`DeepLProvider` (`src/Plugin/AiProvider/DeepLProvider.php`, plugin id **`deepl`**) extends
`Drupal\ai\Base\AiProviderClientBase` and implements **`TranslateTextInterface`**. It is a
single-operation, single-model provider: **`translate_text`** only.

## The client
- `loadClient()` lazily builds **`new \DeepL\Translator($this->apiKey)`** (from `deeplcom/deepl-php`).
  If `$this->apiKey` is empty it first calls `loadApiKey()` (see key handling below).
- `getClient()` returns that `\DeepL\Translator`. `setAuthentication($key)` sets `$this->apiKey` and
  nulls the client so the next call rebuilds it.
- **Endpoint selection is entirely inside the SDK.** The `Translator` constructor picks
  `https://api-free.deepl.com` when the auth key ends in `:fx` (free tier) and `https://api.deepl.com`
  otherwise. This module passes **no** options array, so no `server_url` override, no proxy — TLS
  verification is left at the SDK/cURL default (enabled).

## translateText()
`translateText(TranslateTextInput $input, string $model_id, array $options = []): TranslateTextOutput`:
1. `$text = $input->getText()`.
2. Source language: `$input->getSourceLanguage()`, then `LanguageCode::removeRegionalVariant()` (DeepL
   source langs are region-less, e.g. `en` not `en-GB`). Source may be null → DeepL auto-detects.
3. Target language: `$input->getTargetLanguage()`, then remapped through the configured
   **`language_variants`** map (so a target of `en` becomes `en-GB` or `en-US` per admin choice).
4. Calls `$this->getClient()->translateText($text, $sourceLanguage, $targetLanguage, $options)`.
5. Success → `new TranslateTextOutput($translated->text, $translated, [])` (normalised text +
   raw `\DeepL\TextResult`).
6. Any `\Exception` → `new TranslateTextOutput('', $text, $e->getMessage())` — empty result, original
   text echoed back, error message carried; it never throws.

`$model_id` is the pseudo-model `default` and is unused inside the call — DeepL has one engine.

## Options (`definitions/api_defaults.yml`)
`getApiDefinition()` parses `definitions/api_defaults.yml`, which documents the `translate_text`
parameters the DeepL API accepts and which callers may pass in `$options`: `text`, `target_lang`,
`source_lang`, `context`, `show_billed_characters`, `split_sentences`, `preserve_formatting`,
`formality`, **`glossary_id`** (requires `source_lang`), `tag_handling`, `outline_detection`,
`non_splitting_tags`, `splitting_tags`, `ignore_tags`. Glossaries are the mechanism for enforcing an
organisation's own terminology.

## Model & usability
- `getConfiguredModels()` → `['default' => 'Default']` for every operation type.
- `getModelSettings($model_id, $generalConfig)` returns `$generalConfig` unchanged.
- `isUsable()` returns FALSE unless `ai_provider_deepl.settings:api_key` is set; when an operation type
  is given it must be `translate_text`.
