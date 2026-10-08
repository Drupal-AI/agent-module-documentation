<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Create & configure a DeepL translator provider

DeepL is a **TMGMT translator provider** — a `tmgmt_translator` config entity whose `plugin` is
`deepl_api` (`DeeplApiTranslator`). The API key is held by a **Key entity**, not by the translator
config.

## Add the provider (UI)

1. Create the API key entity first: *Configuration → System → Keys* → Add key
   (`/admin/config/system/keys/add`), key type **DeepL API Key** (`deepl_api_key`). On save the
   `DeepLApiKeyType::validateKeyValue()` method calls DeepL's `getUsage()` to verify the key; an
   invalid key or a DeepL error blocks the save.
2. Go to TMGMT translators (`/admin/tmgmt/translators`, route
   `entity.tmgmt_translator.collection` — the module's `configure` route). Add a translator.
3. Choose plugin **DeepL API** (`deepl_api`).
4. Select your DeepL **authentication key** (`key_select`, filtered to `deepl_api_key`; required)
   and adjust the DeepL options.
5. Save. If the provider already exists, the form shows live DeepL usage
   (`DeeplTranslatorUi::showUsageInfo()`).

The same key entity works for both DeepL Free and Pro keys; `DeepLClient::isAuthKeyFreeAccount()`
distinguishes them from the key string, so there are no longer separate free/pro plugins.

## `tmgmt.translator.<name>` settings (schema `tmgmt_deepl_settings`)

| Key | Meaning / values |
|---|---|
| `auth_key_entity` | Id of the Key entity holding the DeepL API key (required). |
| `model_type` | `latency_optimized` (default) / `prefer_quality_optimized` (Pro v2 next-gen). |
| `formality` | `default` / `more` / `less` / `prefer_more` / `prefer_less`. |
| `split_sentences` | `0` (none) / `1` (punctuation + newlines, default) / `nonewlines`. |
| `preserve_formatting` | int/bool — preserve source formatting. |
| `tag_handling` | `0` (off) / `xml` / `html`. |
| `tag_handling_version` | `v1` / `v2` (v2 requires `prefer_quality_optimized`; validated). |
| `outline_detection` | int/bool — automatic XML outline detection (xml only). |
| `splitting_tags` / `non_splitting_tags` / `ignore_tags` | Comma-separated tag lists (xml only). |
| `enable_context` | bool — adds a "Translation context" field to the job checkout form. |
| `translate_documents` | bool — allow DeepL document translation for file sources. |
| `enable_document_minification` | bool — minify large documents before upload (documents only). |
| `omit_partner_id` | bool — do not send the `deepl-partner-integration-undpaul` app id. |
| `log_api_requests` | bool — log one entry per DeepL request/retry (off by default; noisy). |
| `max_queries` | int — texts per DeepL request; one of `5,10,20,30,40,50` (default `20`). |
| `auto_accept` | bool (from TMGMT base) — auto-accept returned translations. |

Defaults come from `DeeplTranslator::defaultSettings()`. Blank/NULL settings are stripped and fall
back to the plugin defaults (`getDefaultSettings()`).

## Validation notes (`DeeplTranslatorUi::validateConfigurationForm()`)

- Turning `tag_handling` off clears `outline_detection`, `splitting_tags`, `non_splitting_tags`,
  `ignore_tags`.
- `tag_handling_version = v2` is rejected while `model_type = latency_optimized`.

## Create the provider in code (scriptable — saving does not call DeepL)

```php
use Drupal\tmgmt\Entity\Translator;
Translator::create([
  'name' => 'deepl',
  'label' => 'DeepL',
  'plugin' => 'deepl_api',
  'settings' => [
    'auth_key_entity' => 'deepl_api_key',   // id of a Key entity, NOT the raw key
    'formality' => 'prefer_more',
    'model_type' => 'latency_optimized',
    'auto_accept' => TRUE,
    'split_sentences' => '1',
    'tag_handling' => 'html',
    'tag_handling_version' => 'v1',
    'max_queries' => 20,
  ],
])->save();
```

```bash
drush cget tmgmt.translator.deepl plugin
drush cget tmgmt.translator.deepl settings
```

## API key storage

The DeepL API key is resolved at request time from the selected Key entity
(`DeepLClientFactory::resolveApiKey()` → `KeyRepository::getKey()->getKeyValue()`); the translator
config only stores the key entity id. Store the key itself with any Key provider (environment
variable, file, config). Saving the translator config does not contact DeepL; translating a job, the
key-save validation, and the usage display do.
