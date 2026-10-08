<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Huggingface Provider — configuration

## Install / enable

```
composer require drupal/ai_provider_huggingface
drush en ai_provider_huggingface
```

Requires `drupal/ai` (`^1.3.x-dev@dev`) and `drupal/key`. You also need a Hugging Face account with
an access token that has the `inference.serverless.write` scope.

`ai_provider_huggingface_install()` (in the `.install`) migrates any leftover config from the older
AI-core `provider_huggingface` submodule (`provider_huggingface.settings` → this module's config,
copying `api_key` if the new config is empty) and uninstalls that old submodule.

## Config object

Config name (`HuggingfaceConfigForm::CONFIG_NAME`): **`ai_provider_huggingface.settings`**.

- `api_key` (string, schema `config/schema/…schema.yml`, install default `''`) — the **machine name
  of a Key entity** (drupal/key) holding the Hugging Face access token, chosen via a `key_select`
  element in the form. It is *not* the token itself.
- `models` — written by `HuggingfaceConfigForm::submitForm()` from the AI module's models-table
  fields (`model__<type>__…`). (The models sub-key is not declared in the config schema.)

`HuggingfaceProvider::loadApiKey()` (from the base class) resolves the Key and
`setAuthentication()`/`loadClient()` push the token into `HuggingfaceApi::setApiToken()`, which sends
it as `Authorization: Bearer …`. The token is not logged and not rendered back into the form.

## Routes & permissions

- `ai_provider_huggingface.settings_form` → `/admin/config/ai/providers/huggingface`, requirement
  `_permission: 'administer ai providers'` (the AI module's permission). Menu link
  `ai_provider_huggingface.settings_menu` under `ai.admin_providers`.
- `ai_provider_huggingface.autocomplete.models` →
  `/admin/ai/huggingface/autocomplete/models`, `_format: json`, requirement
  `_permission: 'autocomplete huggingface model list'` (declared in `.permissions.yml`). No
  `_access: TRUE` routes exist.

## Models table & autocomplete

`$hasPredefinedModels = FALSE`, so the form embeds the AI module's models table
(`AiProviderFormHelper::getModelsTable`). For each model `HuggingfaceProvider::loadModelsForm()` adds
one required **Endpoint** field (`huggingface_endpoint`):

- A **model name** (e.g. `mistralai/Mistral-7B-Instruct-v0.3`) → routed to serverless inference at
  `https://router.huggingface.co/hf-inference/models/<name>` (chat uses
  `https://router.huggingface.co/v1/chat/completions`), or
- A full **URL** to a dedicated Hugging Face Inference Endpoint (used verbatim when it starts with
  `http://`/`https://`; see `HuggingfaceApi::finalEndpoint()`).

The field autocompletes via `HuggingfaceAutocomplete::models`, which queries
`https://huggingface.co/api/models?pipeline_tag=<tag>&search=<q>&…` (fixed host) and returns matching
model ids as JSON. The pipeline tag is derived from the operation type
(`HuggingfaceProvider::$supportedTypes`).
