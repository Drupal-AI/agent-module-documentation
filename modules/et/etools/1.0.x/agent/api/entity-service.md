<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity helper service + Twig functions

## Install & enable

```bash
composer require drupal/etools
drush en etools -y
```

No dependencies are declared in `etools.info.yml`. No config, no permissions.

## Service `etools.entity` — `Drupal\etools\EtoolsEntity`

Defined in `etools.services.yml` (no constructor args). Two methods, both operating on a
`ContentEntityInterface` (`src/EtoolsEntity.php`):

### `getFieldValue($entity, string $field_name, string $property_name = '')`

Returns a field's raw value(s) without hand-writing the item loop.

- Returns `NULL` immediately if `$entity->hasField($field_name)` is false.
- Resolves `$property_name` from the field's storage definition
  (`getFieldStorageDefinition()->getMainPropertyName()`) when not given; throws `\Exception` if it
  still can't be determined.
- Iterates all items and collects the `$property_name` value from each (skipping NULLs).
- Single-cardinality field → the single value (or `NULL`); multi-value field → an array (or `[]`).
- Does **not** perform an access check — it reads the stored value, like `entity.field.value` in a
  template. Use `getFieldDisplay()` when access-aware rendering is required.

### `getFieldDisplay($entity, string $field_name, $display_options = 'default')`

Returns a render array for the field.

- Checks `$entity->access('view', NULL, TRUE)`; renders the field only when access is allowed **and**
  the field exists, via `$entity->get($field_name)->view($display_options)`.
- `$display_options` is a view-mode machine name (default `'default'`) or a field display config array.
- Merges cacheability from the render array, the access result, and the entity onto the returned
  render array (`CacheableMetadata`), so it is cache-correct.

Call from PHP: `\Drupal::service('etools.entity')->getFieldValue($node, 'field_tags');`

## Twig functions — `Drupal\etools\EtoolsTwigExtension`

Registered via the `twig.extension`-tagged service `etools.twig_extension`
(constructor arg `@etools.entity`). `getFunctions()` exposes two functions that map straight to the
service methods (`src/EtoolsTwigExtension.php`):

- `etools_field_value(entity, field_name, property_name = '')` → `EtoolsEntity::getFieldValue()`.
- `etools_field_display(entity, field_name, display_options = 'default')` → `EtoolsEntity::getFieldDisplay()`.

Examples:

```twig
{{ etools_field_value(node, 'field_subtitle') }}
{% for tid in etools_field_value(node, 'field_tags', 'target_id') %} … {% endfor %}
{{ etools_field_display(node, 'body') }}
{{ etools_field_display(node, 'field_image', 'teaser') }}
```
