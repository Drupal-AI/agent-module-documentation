<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Placing a field block

## Via the UI

1. *Structure › Block layout* (`/admin/structure/block`), pick a region → **Place block**.
2. Choose **Content field** / **User field** / **Taxonomy term field** (admin labels come from
   `FieldBlockDeriver`: `@type field`). One entry per enabled entity type.
3. In the block form:
   - **Use field label as block title** (`label_from_field`, default on) — when on, the rendered
     field's `#title` becomes the block title.
   - **Field** (`field_name`) — every *field storage* on that entity type, so fields from all
     bundles are listed. Changing it reloads the formatter select over AJAX.
   - **Formatter** (`formatter_id`) — formatters applicable to that field type.
   - **Formatter settings** — the formatter's own settings form, embedded in a fieldset.
4. Set visibility/region as usual and save.

## The resulting config

```yaml
# block.block.<id>
plugin: 'fieldblock:node'
region: sidebar
theme: olivero
settings:
  id: 'fieldblock:node'
  label: 'Article body'
  label_display: visible
  provider: fieldblock
  label_from_field: true
  field_name: body
  formatter_id: text_default
  formatter_settings: {  }
```

Schema: `block.settings.fieldblock:*` in `config/schema/fieldblock.schema.yml`
(`label_from_field` bool, `field_name` string, `formatter_id` string, `formatter_settings` typed
as `field.formatter.settings.[%parent.formatter_id]`).

Dependencies are calculated automatically: the field storage's config name
(`field.storage.node.body`) plus the module providing the chosen formatter.

## Scripted placement

```php
\Drupal\block\Entity\Block::create([
  'id' => 'article_body_block',
  'theme' => 'olivero',
  'region' => 'sidebar',
  'weight' => 0,
  'plugin' => 'fieldblock:node',
  'settings' => [
    'id' => 'fieldblock:node',
    'label' => 'Article body',
    'label_display' => 'visible',
    'provider' => 'fieldblock',
    'label_from_field' => TRUE,
    'field_name' => 'body',
    'formatter_id' => 'text_default',
    'formatter_settings' => [],
  ],
  'visibility' => [],
])->save();
```

Read one back:

```bash
drush cget block.block.article_body_block settings
drush ev 'foreach (\Drupal::service("fieldblock.block_storage")->loadFieldBlocks() as $b) {
  $s = $b->get("settings");
  print $b->id() . " " . $b->get("plugin") . " field=" . $s["field_name"] . " formatter=" . $s["formatter_id"] . PHP_EOL;
}'
```

## Choosing a formatter id

```bash
drush ev '$m = \Drupal::service("plugin.manager.field.formatter");
print implode(", ", array_keys($m->getOptions("text_with_summary"))) . PHP_EOL;'
```

Common pairs: `body`/`text_with_summary` → `text_default`, `text_summary_or_trimmed`;
image fields → `image`; `datetime` → `datetime_default`; entity reference → `entity_reference_label`.
