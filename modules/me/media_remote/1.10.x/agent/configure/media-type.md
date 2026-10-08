<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Create and configure a Remote Media type

There is **no settings form and no configure route**. All configuration is a media type plus its
`default` view display.

## The three things that must be true

1. A `media_type` config entity whose `source` is `media_remote`.
2. `source_configuration.source_field` pointing at a `string` field on that bundle.
3. `core.entity_view_display.media.<bundle>.default` must give that field one of the
   **`media_remote_*` formatters** — this is what selects the provider, drives URL validation and
   supplies the auto-name. Skipping it makes every save throw
   `LogicException: The Remote Media validator needs the _default_ media display to be configured…`.

The UI enforces step 3 by nudging you: `media_remote_form_media_type_add_form_alter()` appends a
submit handler that, after you add a type using this source, sets a warning ("you need to configure
a Remote Media formatter in the *<source field>* field") and redirects to
`entity.entity_view_display.media.default`.

## Via the UI

1. */admin/structure/media/add* → **Media source: Remote Media URL** → Save.
2. You land on the type's *Manage display*; set the source field's format to the provider you want
   (e.g. **Remote Media - Loom**), adjust width/height, **Save**.
3. Add a media item at */media/add/<bundle>* and paste a URL — it is validated against that
   provider's regex.

## Via drush (scriptable end to end)

```php
use Drupal\media\Entity\MediaType;
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\Core\Entity\Entity\EntityViewDisplay;

// 1. The media type.
$type = MediaType::create(['id' => 'mr_loom', 'label' => 'Remote Loom', 'source' => 'media_remote']);
$type->save();

// 2. The source field. createSourceField() returns an unsaved FieldConfig whose storage
//    must be created first. Default generated name: field_media_media_remote.
$field = $type->getSource()->createSourceField($type);
FieldStorageConfig::create($field->getFieldStorageDefinition()->toArray())->save();
$field->save();
$type->set('source_configuration', ['source_field' => $field->getName()])->save();

// 3. The provider formatter on the DEFAULT display.
$display = EntityViewDisplay::load('media.mr_loom.default')
  ?: EntityViewDisplay::create(['targetEntityType' => 'media', 'bundle' => 'mr_loom', 'mode' => 'default', 'status' => TRUE]);
$display->setComponent($field->getName(), [
  'type' => 'media_remote_loom',
  'label' => 'hidden',
  'region' => 'content',
  'weight' => 0,
  'settings' => [
    'formatter_class' => 'Drupal\media_remote\Plugin\Field\FieldFormatter\MediaRemoteLoomFormatter',
    'width' => 960, 'height' => 600,
  ],
])->save();
```

`setComponent()` merges each formatter's `defaultSettings()`, so `formatter_class` is filled in
automatically if you omit it — but always confirm it landed, because everything depends on it.

## Resulting config

```yaml
# core.entity_view_display.media.mr_loom.default
content:
  field_media_media_remote:
    type: media_remote_loom
    label: hidden
    settings:
      formatter_class: 'Drupal\media_remote\Plugin\Field\FieldFormatter\MediaRemoteLoomFormatter'
      width: 960
      height: 600
    region: content
```

```yaml
# media.type.mr_loom
source: media_remote
source_configuration:
  source_field: field_media_media_remote
```

## Read it back

```bash
drush cget media.type.mr_loom source_configuration
drush cget core.entity_view_display.media.mr_loom.default content.field_media_media_remote
```

```bash
# which media types use this source?
drush php:eval 'foreach (\Drupal\media\Entity\MediaType::loadMultiple() as $t) {
  if ($t->getSource()->getPluginId() === "media_remote") {
    print $t->id() . " -> " . $t->getSource()->getConfiguration()["source_field"] . "\n";
  }
}'
```

## Notes

- One shared field storage `media.field_media_media_remote` is reused by every Media Remote type
  created through `createSourceField()`; deleting it removes the field from all of them.
- The source exposes a single metadata attribute, `name`, used for `default_name` — see
  [../plugins/source-and-validation.md](../plugins/source-and-validation.md).
- Thumbnails fall back to `default_thumbnail_filename = generic.png`; there is no remote thumbnail
  fetching.
- Nothing here is per-view-mode except the provider choice, which is read from `default`
  regardless of which view mode you are rendering.
