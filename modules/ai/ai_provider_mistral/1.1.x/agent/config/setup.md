<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & setup — ai_provider_mistral

## Install
```
composer require drupal/ai_provider_mistral
drush en ai_provider_mistral -y
```
Pulls in `drupal/ai`, `drupal/key` and the `partitech/php-mistral` PHP library. PHP 8.2+.

## Create the API key (Key module)
The provider stores only a *reference* to a Key entity, never the raw secret. Create a Key holding
the Mistral API key (from https://console.mistral.ai/api-keys/). Best practice on this project is the
Key module's environment provider so the secret lives in an env var, not in exported config.

## Connect it
Visit `/admin/config/ai/providers/mistral` (permission `administer ai providers`,
`restrict access: true`). Form: `Drupal\ai_provider_mistral\Form\MistralConfigForm`, id
`mistral_settings`, editing config object `ai_provider_mistral.settings`.

- **Mistral API Key** — a `key_select` element; pick the Key entity created above.
- **Advanced → Custom API Host** — optional textfield (`host`). Overrides the default
  `https://api.mistral.ai` endpoint; described as useful for mock servers or proxies. Leave empty for
  the default. Only holders of `administer ai providers` can set it.

On submit the provider registers itself as the default when none is configured yet:
`defaultIfNone('chat', 'mistral', 'mistral-large-latest')` and
`defaultIfNone('embeddings', 'mistral', 'mistral-embed')`.

## Config schema
`ai_provider_mistral.settings` (config_object):
- `api_key` (string, required) — the Key entity id.
- `host` (string) — optional API host override.

Install default (`config/install/ai_provider_mistral.settings.yml`): both empty.

## Upgrade note
`hook_install` copies configuration from the legacy in-`ai` submodule `provider_mistral` (config
object `provider_mistral.settings`) into `ai_provider_mistral.settings` and uninstalls the old
submodule, so existing keys carry over.

## Usability
`isUsable()` returns FALSE until `api_key` is set; otherwise TRUE for chat/embeddings/moderation
(and for vision-capable chat).
