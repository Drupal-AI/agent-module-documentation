<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the resolution strategy

Conflict has **no settings form or configure route** (`configure: null`, no `*.routing.yml`).
Configuration is the `conflict.settings` config object, edited via config API / import.

## `conflict.settings`

Schema `conflict.settings` (`config/schema/conflict.schema.yml`): a nested `resolution_type` map
`entity_type → bundle → value`, where value is **`inline`** or **`dialog`**. Shipped default
(`config/install/conflict.settings.yml`):

```yaml
resolution_type:
  default:
    default: inline
```

## Resolution of a value (from `conflict.module`)

For an entity of `entity_type_id` / `bundle`, the strategy is looked up with fallbacks:

```
resolution_type.<entity_type_id>.<bundle>
  ?? resolution_type.<entity_type_id>.default
  ?? resolution_type.default.default        # => 'inline' unless changed
```

- `inline` — the conflict-resolution UI is embedded directly in the entity edit form.
- `dialog` — conflicts are presented in a modal dialog.

## Set it (scriptable)

```php
// Use a modal dialog for Article nodes:
\Drupal::configFactory()->getEditable('conflict.settings')
  ->set('resolution_type.node.article', 'dialog')
  ->save();

// Change the global default:
\Drupal::configFactory()->getEditable('conflict.settings')
  ->set('resolution_type.default.default', 'dialog')
  ->save();
```

```bash
# Read the effective value for node.article (may be null if only a fallback applies):
drush php:eval 'print \Drupal::config("conflict.settings")->get("resolution_type.node.article");'
drush cget conflict.settings resolution_type
```

To remove a bundle-specific override, `clear('resolution_type.node.article')` (or the whole
`resolution_type.node`) and save so it falls back to the default.

> Note: because `drush cset conflict.settings resolution_type.node.article dialog` writes a plain
> string it is fine here, but never use `drush cset` for the module's boolean-typed config in
> other modules — the string `"false"` casts to boolean TRUE. These values are strings.
