<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure: Display mode field + Selected display mode formatter

There is **no admin settings page** (`configure` route is null). All configuration is
per-field on a bundle's Manage fields / form display / display tabs, or via config/Drush.

## 1. Add the Display mode field

Add a field of type `entity_reference_display` (UI label **"Display mode"**, category
*Reference*) to the bundle that also has your entity reference field.

- Storage is a single `varchar(255)` column `value`. **Cardinality is forced to 1** — the
  storage form's cardinality control is disabled by the module.
- Default widget: `options_select` (a select list). Any `list_string` widget also works,
  e.g. `options_buttons` (radios) — the module registers the field type on every widget
  that supports `list_string`.

### Field settings (per-field, `field.field_settings.entity_reference_display`)

| Key | Type | Meaning |
|---|---|---|
| `exclude` | sequence of strings | View-mode machine names to remove from the option list. |
| `negate` | boolean | If TRUE, `exclude` becomes an **allow-list**: only those modes are offered. |

Options are ALL view modes across entity types (deduped, alphabetical) with `default`
prepended as "Default". Filtering: an option is offered when
`(!negate && !in exclude) || (negate && in exclude)`.

## 2. Put the formatter on the reference field

On the same bundle's **Manage display**, set the entity reference field's format to
**"Selected display mode"** (`entity_reference_display_default`). It is only offered when
the bundle contains at least one `entity_reference_display` field (`isApplicable()`).

- Formatter setting `display_field`: which display-mode field supplies the view mode. The
  select is only shown when more than one display-mode field exists; otherwise the sole
  field is used automatically.
- At render the formatter reads that field's value off the host entity and renders the
  referenced entities with it; wrapper gets class `erd-list--<view_mode>`.
- With `entity_reference_revisions` installed, the default formatter class is swapped to a
  revisions-aware subclass automatically.

## Do it with Drush (php:eval)

```php
// Create storage + field for a "display mode" field on node.article.
\Drupal\field\Entity\FieldStorageConfig::create([
  'field_name' => 'field_display_mode', 'entity_type' => 'node',
  'type' => 'entity_reference_display', 'cardinality' => 1,
])->save();
\Drupal\field\Entity\FieldConfig::create([
  'field_name' => 'field_display_mode', 'entity_type' => 'node', 'bundle' => 'article',
  'label' => 'Display mode',
  'settings' => ['exclude' => ['full' => 'full'], 'negate' => FALSE],
])->save();
// Expose it on the form display with the select widget.
\Drupal::service('entity_display.repository')
  ->getFormDisplay('node', 'article', 'default')
  ->setComponent('field_display_mode', ['type' => 'options_select'])->save();
```
