# Drush commands

Registered in `drush.services.yml` (`Drupal\key\Commands\KeyCommands`). Require Drush >= 9.

| Command | Alias | Purpose |
|---|---|---|
| `key:save` | `key-save` | Create/update a key (id, `--label`, `--key-type`, `--key-provider`, `--key-provider-settings`, `--key-input`). |
| `key:delete <id>` | `key-delete` | Delete a key. |
| `key:list` | `key-list` | List keys (`--key-type`, `--key-provider` filters). |
| `key:type-list` | `key-type-list` | List available key types (`--group`). |
| `key:provider-list` | `key-provider-list` | List available key providers. |
| `key:value-get <id>` | `key-value-get`, `key-value` | Print a key's resolved value (`--base64`). |

Example — create an env-backed authentication key:
```
drush key:save openai_api_key --label='OpenAI API Key' --key-type=authentication \
  --key-provider=env \
  --key-provider-settings='{"env_variable":"OPENAI_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```
