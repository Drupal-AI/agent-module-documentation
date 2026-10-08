# Configure Trailing Slash

Settings form: `/admin/config/trailing-slash/settings` (route
`trailing_slash.admin_settings_form`, class `SettingsForm`), gated by the module permission
**`administer trailing slash`** (`restrict access: TRUE`). Config object: `trailing_slash.settings`.

## Config keys

| Key | Type | Default | Meaning |
|---|---|---|---|
| `enabled` | bool | `false` | Master switch. When off, the path processor does nothing. |
| `paths` | string | `''` | Newline-separated path patterns to slash. Each starts with `/`, wildcards allowed (e.g. `/book`, `/user/*`). Matched with core `path.matcher`. |
| `enabled_entity_types` | string (**PHP-serialized** array) | `''` | Nested map `entity_type_id → bundle_id → bool`; a truthy leaf means "slash URLs of this bundle". |

Schema `trailing_slash.settings` (`config/schema/trailing_slash.schema.yml`) types all three as
`boolean`/`string`/`string` — note `enabled_entity_types` is stored as a serialized string, not
structured config. The form builds bundle checkboxes for every content entity type
(`TrailingSlashSettingsHelper::getContentEntityTypes()`), and `submitForm()` saves the checkbox
tree with `serialize()`.

## Form fields

- **Enabled** — the `enabled` checkbox.
- **List of paths with trailing slash** — textarea → `paths`.
- **Enabled entity types** — a details group with a nested details section per content entity
  type, each containing a checkbox per bundle → `enabled_entity_types`.

## Setting it in code

`enabled_entity_types` is serialized, so set it as a serialized string:

```php
\Drupal::configFactory()->getEditable('trailing_slash.settings')
  ->set('enabled', TRUE)
  ->set('paths', "/about\n/blog/*")
  ->set('enabled_entity_types', serialize([
    'node' => ['article' => 1, 'page' => 0],
    'taxonomy_term' => ['tags' => 1],
  ]))
  ->save();
```

Reading it back: `unserialize($config->get('enabled_entity_types'))`.

## What is never slashed

`<front>`, empty paths, `/admin*` and `/devel*` paths, admin routes, and any final URL segment
containing a `.` (file-like URLs). Paths already ending in `/` are left as-is (idempotent). See
[../extend/architecture.md](../extend/architecture.md).
