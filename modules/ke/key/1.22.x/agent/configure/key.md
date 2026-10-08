# Configure keys

![Keys list](../../../../../../../screenshots/key/1.22.x/keys.png)

A **Key** is a config entity (`key.key.*`, schema `config/schema/key.schema.yml`) built from
three plugin choices. Manage at `/admin/config/system/keys` (route `entity.key.collection`).

Key entity fields: `id`, `label`, `description`, `key_type` + `key_type_settings`,
`key_provider` + `key_provider_settings`, `key_input` + `key_input_settings`.

## Built-in key types (`key_type`)
| id | Purpose |
|---|---|
| `authentication` | Generic API key / password (default). |
| `authentication_multivalue` | Multiple named fields (e.g. username + password) as JSON. |
| `encryption` | Encryption key; setting `key_size` (bits). |
| `user_password` | A user account password. |

## Built-in key providers (`key_provider` — where the value lives)
| id | Settings | Notes |
|---|---|---|
| `config` | `key_value`, `base64_encoded` | Stored in config (exported — avoid for real secrets). |
| `file` | `file_location`, `base64_encoded`, `strip_line_breaks` | Reads a file outside the web root. |
| `env` | `env_variable`, `base64_encoded`, `strip_line_breaks` | Reads an environment variable. |
| `state` | `state_key` | Stored in Drupal state (DB), not config. |

## Built-in key inputs (`key_input` — how a value is entered)
`none`, `text_field` (`base64_encoded`), `textarea_field` (`base64_encoded`),
`generate` (`generated`, `display_once`).

## Environment-variable key (recommended for secrets)
Create via UI (provider = Environment) or drush:
```
drush key:save my_api_key --label='My API key' --key-type=authentication \
  --key-provider=env \
  --key-provider-settings='{"env_variable":"MY_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

## Key Configuration Override
Second entity type (`key.config_override.*`, route `entity.key_config_override.collection` at
`/admin/config/development/configuration/key-overrides`). Injects a key's value into another
config object at runtime via a `config.factory.override` (`KeyConfigOverrides`, priority 10) —
so a real secret replaces a placeholder in exported config without being stored there. Fields:
`config_type`, `config_prefix`, `config_name`, `config_item`, `key_id`.
