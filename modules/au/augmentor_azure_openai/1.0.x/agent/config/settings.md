<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring an Azure OpenAI augmentor

This module has **no settings form, route, or config schema of its own**. Augmentors are created and edited from the base Augmentor module's admin list at **Administration » Configuration » Web services » Augmentors** (`webservices > augmentors`), guarded by the *Administer augmentors* permission (a trusted, security-sensitive permission — see the module README). Config is stored as part of Augmentor's config entities.

## Install / enable
```
composer require drupal/augmentor_azure_openai   # pulls augmentor + openai-php/client
drush en augmentor_azure_openai -y
```
Requires the `augmentor` module and the `openai-php/client` (`^0.10`) library.

## Configuration fields
When you add an augmentor of type **Azure OpenAI Chat** or **Azure OpenAI Completions**, the form combines base + Azure fields.

Inherited from `AugmentorBase::buildConfigurationForm()`:
- **label** — admin label.
- **key** — `key_select` element; picks a **Key module** key entity. The selected key's *value* becomes the Azure `api-key` header at request time (`getKeyValue()` → `keyRepository->getKey()`). The API key is not stored in the augmentor config itself, only the key's machine name.
- **debug** — checkbox; enables the base debug logger.

Added by `AzureOpenAIBase::buildConfigurationForm()` (config keys `base_url`, `api_version`, `prompt`):
- **Base URL** — resource + deployment, e.g. `{resource}.openai.azure.com/openai/deployments/{deployment-id}`. This URL selects the model, so no separate model field exists.
- **API Version** — e.g. `2023-09-15-preview`.
- **Prompt** — template string; `{input}` is substituted with the (prepared) source text. Defaults to `{input}`.

Plugin-specific additions:
- Chat: **Role** (`user` | `assistant`, default `user`).
- Completions: **Advanced settings** → **Temperature** (default `0.3`) and **Max Tokens** (default `4000`).

## How the client is built (`AzureOpenAIBase::getClient()`)
```php
\OpenAI::factory()
  ->withBaseUri($base_url)
  ->withHttpHeader('api-key', $this->getKeyValue())
  ->withQueryParam('api-version', $api_version)
  ->make();
```
Returns an `OpenAI\Client`. TLS verification uses the `openai-php/client` / Guzzle defaults (enabled). The plugin `execute()` methods then call `->chat()->create()` or `->completions()->create()`.

## Operating notes
- Store the Azure key via the **Key** module (env-backed provider recommended) rather than pasting it into a config-stored key type.
- Errors are caught and written to the module logger (`There was an issue obtaining a response from Azure OpenAI...`); `execute()` returns `[]` on failure, so downstream Augmentor actions receive an empty result rather than an exception.
- Because the base URL selects the deployment/model, switching models = editing the Base URL; no code change needed.
