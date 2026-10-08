# Global settings

Config object `pathauto.settings` (schema `config/schema/pathauto.schema.yml`). UI at
`/admin/config/search/path/settings` (route `pathauto.settings.form`). Read/write with
`drush config:get pathauto.settings` / `drush config:set pathauto.settings <key> <value>`.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `separator` | string | `-` | Character replacing spaces/punctuation. |
| `max_length` | int | 150 | Max total alias length. |
| `max_component_length` | int | 100 | Max length per token component. |
| `transliterate` | bool | TRUE | Convert non-ASCII (é→e) to ASCII. |
| `reduce_ascii` | bool | FALSE | Strip remaining non-alphanumeric chars. |
| `case` | bool | TRUE | Lowercase the alias. |
| `ignore_words` | string | `a, an, as, at, …` | Comma-list of stop-words removed. |
| `punctuation` | sequence<int> | hyphen:1 | Per-punctuation action: 0 remove, 1 replace w/ separator, 2 keep. |
| `update_action` | int | 2 | On entity update: 0 do nothing, 1 create new + leave old, 2 create new + delete old, 3 (with Redirect) create redirect. |
| `verbose` | bool | FALSE | Show a message with each generated alias. |
| `enabled_entity_types` | sequence<string> | `[user]` | Entity types pathauto manages (nodes/terms are enabled implicitly by having a pattern). |
| `safe_tokens` | sequence<string> | `alias, path, url, …` | Tokens whose output is a path and must not be cleaned. |

Example:
```
drush config:set pathauto.settings max_length 100 -y
drush config:set pathauto.settings separator _ -y
```

Settings form (`/admin/config/search/path/settings`):
![Pathauto settings form](../../../../../../../screenshots/pathauto/1.15.x/settings-form.png)
