<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Slideshow (`lightning_media_slideshow`) — agent index

Configuration + one service. **No `.module` file, no routes, no permissions, no settings
form (`configure` = null), no config schema, no Drush, no plugin types.**
Dependencies: `drupal:block_content`, `lightning_media`, `slick_entityreference`.

## What it installs (`config/install/`, dependencies **enforced**)

| Config | Value |
|---|---|
| `block_content.type.media_slideshow` | label **Slideshow**, description "A slideshow or carousel of media items.", `revision: false` |
| `field.storage.block_content.field_slideshow_items` | `entity_reference` → `media`, **cardinality `-1`** (unlimited) |
| `field.field.block_content.media_slideshow.field_slideshow_items` | label **Media items**, `required: true`, `handler: default:media`, `target_bundles: null` (all bundles) |
| `core.entity_view_mode.media.slideshow` | a `media.slideshow` view mode |
| `core.entity_form_display.block_content.media_slideshow.default` | form display |
| `core.entity_view_display.block_content.media_slideshow.default` | renders the field with formatter **`slick_entityreference_vanilla`** (`optionset: default`, `skin: default`, label `visually_hidden`) |

Because the dependencies are *enforced*, uninstalling the module deletes the block type and
field — hence the uninstall guard below.

## The one service

```yaml
lightning_media_slideshow.uninstall_validator:
  class: '\Drupal\lightning_media_slideshow\UninstallValidator'
  arguments: ['@entity_type.manager', '@string_translation']
  tags: [{ name: module_install.uninstall_validator }]
  lazy: true
```

It refuses uninstall while any `block_content` of type `media_slideshow` exists:
*"To uninstall Media Slideshow, you must delete all slideshow blocks first."*
Delete the blocks first, then `drush pm:uninstall lightning_media_slideshow`.

`lightning_media_slideshow_update_9001()` downloads Slick 1.8.0 into
`<docroot>/libraries/slick-carousel` when `slick`, `slick-carousel` and `accessible-slick`
are all missing.

## Recipes

```bash
drush config:get block_content.type.media_slideshow
drush config:get field.storage.block_content.field_slideshow_items cardinality
drush config:get field.field.block_content.media_slideshow.field_slideshow_items settings

# restrict slides to image + document media and cap at 6
drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  use Drupal\field\Entity\FieldStorageConfig;
  FieldStorageConfig::loadByName("block_content", "field_slideshow_items")->setCardinality(6)->save();
  $f = FieldConfig::loadByName("block_content", "media_slideshow", "field_slideshow_items");
  $s = $f->getSettings();
  $s["handler_settings"]["target_bundles"] = ["image" => "image", "document" => "document"];
  $f->set("settings", $s)->save();
'
```

Create a slideshow block programmatically:

```php
use Drupal\block_content\Entity\BlockContent;
BlockContent::create([
  'type' => 'media_slideshow',
  'info' => 'Homepage carousel',
  'field_slideshow_items' => [['target_id' => 3], ['target_id' => 4]],
])->save();
```

In the UI: *Content → Blocks → Add content block → Slideshow*, then place the resulting
block from *Structure → Block layout* or a Layout Builder section.
