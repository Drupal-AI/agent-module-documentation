<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Add & configure the read-time field

No settings page. You add an `estimated_read_time` field to a bundle and tune its field,
widget, and formatter settings.

## Add the field (UI)

1. *Structure → Content types → <bundle> → Manage fields → Add field*.
2. Choose field type **Read Time** (`estimated_read_time`).
3. **Field settings** (`field.field.<entity>.<bundle>.<field>` → `settings`):
   - `view_mode` — which view mode of the entity is rendered to measure the text.
   - `words_per_minute` — audience reading speed (default **230**; required, min 1).
4. *Manage form display* — widget **Minutes and seconds** (`estimated_read_time_default`),
   setting `sidebar` (place the field in the form's advanced/sidebar group).
5. *Manage display* — formatter **Estimated read time text** (`estimated_read_time_text`),
   setting `tokenized_string` (default `@minutes min read`; `@minutes` / `@seconds`
   replaced).

## Add the field (drush php:eval)

```php
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;

FieldStorageConfig::create([
  'field_name' => 'field_read_time', 'entity_type' => 'node',
  'type' => 'estimated_read_time',
])->save();
FieldConfig::create([
  'field_name' => 'field_read_time', 'entity_type' => 'node', 'bundle' => 'article',
  'label' => 'Read time',
  'settings' => ['view_mode' => 'full', 'words_per_minute' => 230],
])->save();

// Form display (widget) + view display (formatter):
$fd = \Drupal::service('entity_display.repository')->getFormDisplay('node', 'article', 'default');
$fd->setComponent('field_read_time', [
  'type' => 'estimated_read_time_default',
  'settings' => ['sidebar' => TRUE],
])->save();
$vd = \Drupal::service('entity_display.repository')->getViewDisplay('node', 'article', 'default');
$vd->setComponent('field_read_time', [
  'type' => 'estimated_read_time_text',
  'settings' => ['tokenized_string' => '@minutes min read'],
])->save();
```

## Read settings back

```bash
drush config:get field.field.node.article.field_read_time settings
# words_per_minute + view_mode
drush config:get core.entity_view_display.node.article.default content.field_read_time.settings
# tokenized_string
```

## Behavior notes

- On entity save, if the field item's `auto` is not `0`, minutes/seconds are recomputed (see
  [api/estimator.md](../api/estimator.md)); the stored value always gets `auto => 1` after an
  auto-estimate.
- To pin a manual value, the widget's **Automatically estimate read time** checkbox must be
  **off** (`auto = 0`), then the entered minutes/seconds are kept on save.
- The formatter prints nothing when the referenced token's value is empty (e.g. no
  `@minutes` value), avoiding "0 minutes read".
