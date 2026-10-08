# Configure — ignore patterns & modes

![Config Ignore settings form](../../../../../../../screenshots/config_ignore/3.4.x/settings.png)

UI: `/admin/config/development/configuration/ignore` (route `config_ignore.settings`, permission
`import configuration`). Config object: `config_ignore.settings` (schema
`config/schema/config_ignore.schema.yml`). Two keys: `mode` (`simple`|`intermediate`|`advanced`)
and `ignored_config_entities` (shape depends on mode).

## Modes
| Mode | `ignored_config_entities` shape | Use when |
|---|---|---|
| `simple` | flat list of names | one list applied to both import & export |
| `intermediate` | `{import: [...], export: [...]}` | ignore differs by direction |
| `advanced` | `{create,update,delete}: {import:[...], export:[...]}` | ignore differs by operation & direction |

Internally all modes cascade to the advanced shape; simple = same list for every op/direction.

## Pattern syntax (one per line)
| Pattern | Effect |
|---|---|
| `system.site` | ignore this exact config object |
| `webform.webform.*` | wildcard — ignore all names with this prefix |
| `*` | ignore everything (still lets new modules install; do NOT ignore `core.extension`) |
| `~webform.webform.contact` | force-import exception; overrides a wildcard ignore |
| `user.mail:register_no_approval_required.body` | ignore a single key inside a config object |
| `language.*|*` | collection syntax: ignore all language-collection config |
| `language.fr|field.field.*` | ignore fr translations of fields |
| `language.*|system.site:name` | ignore just the site name in all translations |

Exceptions (`~`) are sorted first so they win over broader ignores.

## settings.php overrides
| Setting | Purpose |
|---|---|
| `$settings['config_ignore_deactivate'] = TRUE;` | turn the module off entirely at runtime |
| `$settings['config_ignore_import_priority'] = -100;` | event priority on import (default -100) |
| `$settings['config_ignore_export_priority'] = -100;` | event priority on export (default -100) |
| `$settings['config_ignore_storage'] = 'active'|'sync'|'source'|'target'|'merge';` | which storage supplies the ignore rules; default = sensible auto-choice based on whether `config_ignore.settings` itself is ignored |

For import, `source` = sync storage (yml files), `target` = database. For export they swap.

## Notes
- The module has no `.permissions.yml`; access reuses core's `import configuration` permission.
- `config_ignore.settings` is itself config, so ignore rules are exportable/deployable.
- Bypass a single ignored item on demand via core's single-config import at
  `/admin/config/development/configuration/single/import`.
