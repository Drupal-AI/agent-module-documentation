<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# xAI Provider — install & configuration

## Install & enable

```bash
composer require drupal/ai_provider_xai
drush en ai_provider_xai -y
```

Composer pulls `drupal/ai` (`^1.0.4`), `drupal/key` (`^1.18`) and `grok-php/client` (`^1.1`). Module
deps `ai:ai` and `key:key` are declared in `ai_provider_xai.info.yml` (packaged `1.0.0-alpha1`).

## Store the API key

1. Create an xAI API key in the xAI console.
2. Create a **Key** entity (Configuration → System → Keys) holding it.
3. Go to **`/admin/config/ai/providers/xai`** (route `ai_provider_xai.settings_form`, form
   `Drupal\ai_provider_xai\Form\XAIConfigForm`) and select the Key in the **xAI API Key** `key_select`
   element. `submitForm()` saves the key id to `ai_provider_xai.settings:api_key`.

The stored value is a Key id; the real token is resolved at call time through the AI base class
`loadApiKey()` (Key repository).

## Config object & schema

`config/install/ai_provider_xai.settings.yml` ships `api_key: ''`. Schema
`config/schema/ai_provider_xai.schema.yml` declares a `config_object` with one string `api_key`.

## Model definition

`definitions/api_defaults.yml` declares chat defaults (`temperature: 0.7`, `top_p: 1`,
`max_tokens: 1024`, `presence_penalty`, `frequency_penalty`, `stop`, `safe_prompt: true`,
`random_seed`) and one model `grok-2` (context length 32768, capability `chat`, `default: true`).
Note the running `XAIProvider::chat()` does **not** currently apply these — it hard-codes its options.

## Access control

The single route is the settings form, guarded by `_permission: 'administer ai providers'` (owned by
the `ai` module). No anonymous, mutation, or callback routes exist in this module.

## Known routing defect

`ai_provider_xai.routing.yml` points `_form` at `\Drupal\ai_provider_openai\Form\XAIConfigForm`, which
does not exist; the correct class is `Drupal\ai_provider_xai\Form\XAIConfigForm`. Fix the namespace if
the settings form fails to load.
