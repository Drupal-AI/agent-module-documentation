<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the AI translator

The module has **no admin page of its own**. It is set up as a TMGMT *translator* on TMGMT's
own collection route `entity.tmgmt_translator.collection` (`/admin/tmgmt/translators`), gated
by TMGMT's `administer tmgmt` permission. Choose the **AI** translator plugin (`plugin: ai`);
the form is built by `Drupal\ai_tmgmt\AiTranslatorUi`.

Prerequisites: enable `ai_tmgmt`, a TMGMT source (e.g. Content Entity Source), and configure at
least one provider in the AI module (`/admin/config/ai/settings`). For the `ai_translate` method
also enable the `ai_translate` submodule and configure its prompts (`/admin/config/ai/translate`).

## Settings form fields

| Field | Settings key | Notes |
|---|---|---|
| Translation method | `model_selection_type` | radios: `ai_translate` (use AI Translate submodule per-language prompts/models) or `ai_tmgmt` (basic prompt below). Required. |
| Chat translator model | `chat_model` | select; options from `ai.provider`→`getSimpleProviderModelOptions('chat')`. Required for `ai_tmgmt`; hidden for `ai_translate`. |
| Tokenizer counting model | `tokenizer_model` | select; options from `ai.tokenizer`→`getSupportedModels()`. Used to size chunks. Required. |
| Prompt | `advanced.prompt` | textarea (system prompt). Default `Translate from %source% into %target% language`. Tokens: `%source%`, `%target%`, `%source_code%`, `%target_code%`. Shown only for `ai_tmgmt`. |
| Maximum length | `advanced.max_tokens` | number, min 200, form default 4096. Max tokens per chunk. |
| Rate limit backoff delay | `advanced.rate_limit_delay` | number of seconds, min 1, default 300. Queue suspension window on HTTP 429. |
| Maximum translation attempts | `advanced.max_attempts` | number, min 1, default 3. Retries per queue item before the job item is aborted. Set 1 to disable retries. |

Validation (`validateConfigurationForm`): `ai_translate` requires the `ai_translate.text_translator`
service to exist; `ai_tmgmt` requires a `chat_model`.

## Config object + schema

Stored on the TMGMT translator config entity `tmgmt.translator.<name>` (`plugin: ai`), under
`settings:`. Schema: `config/schema/ai_tmgmt.schema.yml` → type `tmgmt.translator.settings.ai`
(`model_selection_type`, `chat_model`, `tokenizer_model` strings; `advanced` mapping with
`prompt` string, `max_tokens`/`rate_limit_delay`/`max_attempts` integers).

## Create/set via PHP

```php
use Drupal\tmgmt\Entity\Translator;

Translator::create([
  'name' => 'ai',
  'label' => 'AI',
  'plugin' => 'ai',
  'settings' => [
    'model_selection_type' => 'ai_tmgmt',
    // A single AI-module "simple option" string (provider + model), exactly as
    // listed by \Drupal::service('ai.provider')->getSimpleProviderModelOptions('chat').
    'chat_model' => 'openai__gpt-4o-mini',
    'tokenizer_model' => 'gpt-4o-mini',
    'advanced' => [
      'prompt' => 'Translate from %source% into %target% language',
      'max_tokens' => 4096,
      'rate_limit_delay' => 300,
      'max_attempts' => 3,
    ],
  ],
])->save();
```

## Set via drush

```bash
# Read current settings of an existing AI translator entity:
drush config:get tmgmt.translator.ai settings
# Change one nested value:
drush config:set tmgmt.translator.ai settings.advanced.prompt \
  'Translate from %source% into %target% language in a formal tone'
```

The provider, model catalogue and API credentials all live in the **AI** module; this module
stores only the selections above. `ai_tmgmt.install` ships `update_10001`–`10005` that backfill
`model_selection_type`, `advanced.rate_limit_delay` and `advanced.max_attempts` defaults on
pre-existing translators and migrate old queue-item shapes.
