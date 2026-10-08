<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Auto Translation — configuration

Form `AutoTranslatorSettingsForm` at `/admin/config/system/auto-translation` (route
`auto_translation.settings`, permission `administer auto_translation module`). Stores to config
object `auto_translation.settings`.

## Permissions (`auto_translation.permissions.yml`)
- `administer auto_translation module` (restrict access) — the settings form.
- `auto translation translate content` (restrict access) — allowed to run translations.

## Config keys (`auto_translation.settings`)

| key | values | meaning |
|---|---|---|
| `auto_translation_provider` | `google` \| `libretranslate` \| `deepl` \| `amazon` \| `drupal_ai` | active provider (default `google`) |
| `auto_translation_content_types` | sequence | which content types show the Translate control |
| `auto_translation_excluded_fields` | textarea | field names never translated |
| `auto_translation_bulk_publish` | `draft` \| `publish` | bulk-action output state (default `draft`) |
| `auto_translation_api_enabled` | bool | Google: use paid **server-side** API instead of free endpoint |
| `auto_translation_api_key` | string | provider API key — stored **encrypted** (`encryptApiKey()`) |
| `auto_translation_api_secret` | string | secondary secret where needed |
| `auto_translation_api_deepl_pro_mode` | bool | DeepL: use Pro (`api`) vs Free (`api-free`) host |
| `amazon_access_key` / `amazon_secret_key` | string | Amazon Translate credentials (encrypted) |
| `amazon_region` | string | Amazon region (default `us-east-1`) |
| `enable_debug` | bool | verbose logging to the `auto_translation` channel |

Validation: an API key is required when the Google server API is enabled or the provider is `deepl`
or `libretranslate`; Amazon requires access + secret keys. Keys are `Html::escape`d then encrypted
before save.

## Provider notes
- **Google (free)** — client `translate.googleapis.com/translate_a/single?client=gtx&…`, no key.
- **Google (server)** — `google/cloud-translate` SDK (`TranslateClient`), needs an API key.
- **DeepL** — `https://{api-free|api}.deepl.com/v2/translate`, key required.
- **LibreTranslate** — `https://libretranslate.com/translate`, key required.
- **Amazon Translate** — AWS SDK with region + access/secret keys.
- **Drupal AI** — needs the AI + AI Translate modules and a provider configured for the `translate`
  or `chat` operation type (`\Drupal::service('ai.provider')`).

## Bulk Action plugins (`src/Plugin/Action/`)
- `BulkAutoTranslatePublish` — id `auto_translation_bulk_auto_translate_publish_action`, label
  "Auto Translate and Publish".
- `BulkAutoTranslateDraft` — "Auto Translate" (save as draft).

Both extend `ActionBase`, iterate the entity's missing language translations, and call the utility
per target language. Expose them on a content View / admin listing as bulk operations.

## Form integration
`auto_translation.module` adds the Translate control via `hook_form_node_form_alter`,
`hook_form_media_form_alter`, and a general `hook_form_alter` (block_content `*_block_add_form`,
taxonomy `*_form`), each delegating to `Utility::formTranslate()`.
