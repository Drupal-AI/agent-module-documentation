<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure auto_alter

Form `Drupal\auto_alter\Form\AutoAlterSettingsForm` (form id `auto_alter_form`), route
`auto_alter.settings` at `admin/config/media/auto_alter`. Editable config object:
`auto_alter.settings`.

Access: the route requires `_permission: 'administer Automatic Alternative Text'`. That permission
is **not** declared in any `*.permissions.yml`, so it never appears on `admin/people/permissions`;
in a stock install only user 1 (or a role with a bypass such as one holding no grant but flagged
admin) reaches the form.

## Config keys (`auto_alter.settings`)

| Key | Type | Meaning |
|-----|------|---------|
| `engine` | string | Active plugin id: `azure_cognitive_services` or `alttext_ai`. Selected by the "Image description engine" `select`. **Not in the config schema.** |
| `endpoint` | string | Azure request URL (e.g. `https://westeurope.api.cognitive.microsoft.com/vision/v1.0/describe?maxCandidates=1`). Used by the Azure engine only; ignored by Alttext.ai (its URL is hardcoded). |
| `credential_provider` | string | `config` (store key in config) or `key` (reference a Key entity; option only shown when the `key` module is enabled). |
| `credentials.config.api_key` | string | API key when provider is `config`. |
| `credentials.key.api_key_key` | string | Machine name of a `key` entity (filtered to `type: authentication`) when provider is `key`. |
| `status` | bool | "Show status message to user" — flashes the generated text on save. |
| `suggestion` | bool | Master switch. When `false`, no automatic generation happens at all (see hooks/behavior.md). |
| `alttext_ai_translation_languages` | string[] | Alttext.ai only: extra language codes to request per image. |
| `alttext_ai_auto_populate_translations` | bool | Alttext.ai only: fill new content translations with translated alt instead of copying the source. |

Install defaults (`config/install/auto_alter.settings.yml`): `endpoint: ''`,
`credential_provider: 'config'`, empty credentials, `status: false`, `suggestion: false`,
`alttext_ai_translation_languages: []`, `alttext_ai_auto_populate_translations: false`. Note
`engine` has no default and no schema entry, so it is `NULL` until the form is saved
(update hook `auto_alter_update_9001` backfills it to `azure_cognitive_services` for old sites that
already had a key).

## Engine specifics

- **Azure** (`AzureVision::buildConfigurationForm`): requires `endpoint` + an API key. Validation
  posts the bundled `image/test.jpg` to the endpoint and expects a caption back; failure blocks save.
  The key is sent as the `Ocp-Apim-Subscription-Key` header.
- **Alttext.ai** (`AlttextAi::buildConfigurationForm`): requires only an API key (posted as
  `X-API-Key`); validation just checks the key is ≥32 chars. Adds the "Translation Settings"
  fieldset (`alttext_ai_translation_languages`, `alttext_ai_auto_populate_translations`).

## Set via PHP / drush

```php
$config = \Drupal::configFactory()->getEditable('auto_alter.settings');
$config
  ->set('engine', 'alttext_ai')
  ->set('credential_provider', 'config')
  ->set('credentials.config.api_key', getenv('ALTTEXT_AI_KEY'))
  ->set('suggestion', TRUE)
  ->set('status', FALSE)
  ->save();
```

For Azure, also set `endpoint`. To use a Key entity instead of storing the key in config:

```bash
drush cset auto_alter.settings credential_provider key -y
drush cset auto_alter.settings credentials.key.api_key_key my_key_entity -y
```

`AutoAlterCredentials::setCredentials()` resolves the key: for `config` it reads
`credentials.config.api_key`; for `key` it loads the named Key entity and calls `getKeyValue()`.

## Side effects

- `hook_install` (and `auto_alter_update_8400`) create image style `auto_alter_help`
  (image_scale 1440×1440 → image_convert jpg). `getUri()` routes any file over 1 MB through this
  style before sending it to the provider. `hook_uninstall` deletes the style.
- `hook_requirements` (runtime) raises `REQUIREMENT_ERROR` when the resolved API key is empty, or
  when `endpoint` is empty for the Azure engine (Alttext.ai skips the endpoint check).
