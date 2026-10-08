<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ElevenLabs configuration & API key

## Install & enable

```bash
composer require drupal/elevenlabs   # pulls drupal/ai ^1.0.5 and drupal/key ^1.18
drush en elevenlabs -y
```

Dependencies (`elevenlabs.info.yml`): `ai:ai` and `key:key`. No submodules, no permissions of its
own, no Drush commands.

## Create the Key first

The module never stores the raw secret — it stores a **Key entity id**. Create the Key (Key's env
provider keeps the secret in an environment variable, out of exported config):

```bash
drush key:save elevenlabs_api_key --label='ElevenLabs API Key' \
  --key-type=authentication --key-provider=env \
  --key-provider-settings='{"env_variable":"ELEVENLABS_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

The ElevenLabs API key must have access to: Text to Speech, Speech to Speech, Audio Isolation,
Users, Voices, Models and History (the service calls all of these endpoints).

## The settings form

Route **`elevenlabs.settings`** → `/admin/config/system/eleven-labs-settings`
(`elevenlabs.routing.yml`), permission **`administer site configuration`**. Menu link
`elevenlabs.settings` (title *"ElevenLabs Settings"*) is placed under parent
`ai.admin_providers` (*AI → Providers*) by `elevenlabs.links.menu.yml`.

`Form/ElevenLabsSettingsForm` (extends `ConfigFormBase`, form id `elevenlabs_settings`) exposes a
single required field:

```php
$form['api_key'] = [
  '#type' => 'key_select',
  '#title' => $this->t('ElevenLabs API Key'),
  '#default_value' => $config->get('api_key'),
  '#required' => TRUE,
];
```

`submitForm()` saves the selected Key id into config `elevenlabs.settings:api_key`.

## Config object & schema

- Config name constant: `ElevenLabsSettingsForm::CONFIG_NAME = 'elevenlabs.settings'`.
- Install default (`config/install/elevenlabs.settings.yml`): `api_key: ''`.
- Schema (`config/schema/elevenlabs.schema.yml`):

```yaml
elevenlabs.settings:
  type: mapping
  label: 'Elevenlabs Settings'
  mapping:
    api_key:
      type: string
      label: 'The API key for Elevenlabs via Key module'
```

`api_key` is the **Key entity machine name**, not the secret. At runtime
`ElevenLabsApiService::__construct()` reads it and resolves the value:

```php
$apiKey = $this->configFactory->get(ElevenLabsSettingsForm::CONFIG_NAME)->get('api_key');
if ($apiKey) {
  $this->apiKey = $this->keyRepository->getKey($apiKey)->getKeyValue();
}
```

`ElevenlabsProvider::isUsable()` returns FALSE until `elevenlabs.settings:api_key` is set, so the
provider only advertises itself once a key is chosen.
