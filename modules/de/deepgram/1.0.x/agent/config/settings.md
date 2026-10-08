<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Deepgram — install & configuration

## Install / enable

1. Requires `drupal/ai` (`^1.0.0-beta8`) and `drupal/key` (`^1.18`) — see `composer.json`.
   `composer require drupal/deepgram`, then enable `deepgram` (pulls in `ai` and `key`).
2. Create a **Key entity** holding your Deepgram API key (get one from a Deepgram account).
   Use whichever Key provider you prefer (env variable, file, or config).
3. Go to **`/admin/config/deepgram/settings`** ("Setup Deepgram", route `deepgram.settings`,
   permission `administer site configuration`; menu link under the AI providers group,
   `deepgram.links.menu.yml`) and select that Key in the **Deepgram API Key** field.

## Config object

- **Name:** `provider_deepgram.settings` (constant `DeepgramConfigForm::CONFIG_NAME`).
- **Schema:** `config/schema/provider_deepgram.schema.yml` — one mapping key `api_key`
  (`string`, required, label "API Key").
- **Default install value:** `config/install/provider_deepgram.settings.yml` sets
  `api_key: ""`.
- **Important:** `api_key` stores the **Key entity ID**, not the secret itself. The form field
  (`DeepgramConfigForm::buildForm`) is a `key_select` element; `submitForm()` saves the chosen
  key ID into config. The real secret is resolved at runtime by the Key module.

## How the key reaches the API

In `Drupal\deepgram\Deepgram::__construct()` the stored Key ID is read from config and
resolved via `KeyRepository::getKey($id)->getKeyValue()` into the private `$apiKey`. It is then
sent as an `Authorization: Token <key>` header (`makeRequest()`), over HTTPS to
`https://api.deepgram.com/v1/`. If no key is configured, `transcribe()`/`textToSpeech()`
short-circuit and return empty. The AI module can also override the key per operation through
`DeepgramProvider::setAuthentication($key)` → `Deepgram::setApiKey()`.

## Notes

- The bundled `readme.md` "How to use" steps mislabel the settings path (they mention a Google
  Places URL) — the correct settings route is `/admin/config/deepgram/settings`.
- No permissions are defined by this module; no `hook_install`/`hook_uninstall`.
