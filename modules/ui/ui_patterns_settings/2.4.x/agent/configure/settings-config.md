# Declaring settings & the mapping config

## Settings in a pattern definition (`*.ui_patterns.yml`)

A pattern gains a `settings` block (peer of `fields`). Each setting has a `type` (a
`UiPatternsSettingType` plugin id) plus type-specific options:

```yaml
card:
  label: Card
  settings:
    modifier:
      type: textfield
      label: Modifier
      description: Extra CSS modifier
    url:
      type: token
      label: URL
      default_value: "[node:url]"
    attributes:
      type: attributes
      label: Attributes
    variant:
      type: select
      label: Variant
      options:
        default: Default
        featured: Featured
```

In the Twig template you use the values directly (`{{ modifier }}`, `{{ url }}`,
`{{ attributes }}`) — the setting type normalizes them, so no `hook_preprocess` is needed.
Settings are edited wherever the pattern is placed: a Layout Builder / Display Suite pattern
layout, a field formatter, or a UI Patterns block.

## The `ui_patterns_settings.settings` config object

This is the module's **only** config object (schema
`config/schema/ui_patterns_settings.schema.yml`). It holds one key, `mapping`, that binds an
**entity field** to a **pattern setting** so the field's value feeds the setting (via the
`SettingFieldSource` source plugin):

```yaml
ui_patterns_settings.settings:
  mapping:
    node--field_promo: "card::title"     # {entity_type}--{field_name}: "{pattern_id}::{setting_id}"
    node--field_style: "card::variant"    # setting_id 'variant' drives the pattern variant
```

- The key is the field id with `.` replaced by `--` (e.g. `node.field_promo` → `node--field_promo`).
- The value is `"{pattern_id}::{setting_id}"`.
- Managed in code by `\Drupal\ui_patterns_settings\ConfigManager::addMapping($field_id, "$pattern::$setting")`
  (passing `NULL` removes the entry).

### Read / write

```bash
drush cget ui_patterns_settings.settings mapping
```

```php
\Drupal::service('ui_patterns_settings.config_manager')
  ->addMapping('node.field_promo', 'card::title');   // stores node--field_promo => card::title

// or directly:
\Drupal::configFactory()->getEditable('ui_patterns_settings.settings')
  ->set('mapping', ['node--field_promo' => 'card::title'])
  ->save();
```

A mapping whose `setting_id` is `variant` makes that field drive the pattern's variant
(`ConfigManager::findVariantMappings()`).
