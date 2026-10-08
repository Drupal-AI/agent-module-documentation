# Create / inspect a Crowdriff media type

The module has **no configure route and no settings** of its own. All configuration is core
Media: you create a **Media type** whose *Media source* is **Media Crowdriff**, and (optionally)
tune the embed **formatter** on that type's view display.

## Via the UI

1. *Structure → Media types → Add media type* (`/admin/structure/media/add`).
2. **Media source**: choose **Media Crowdriff**. Save — core auto-creates a `string_long`
   source field (`field_media_media_crowdriff`).
3. Editors then add assets at *Content → Media → Add media → <your type>*, or through the
   **Media Library** on any media field, pasting the fragment from Crowdriff's embed dialog
   into the **Embed Code** textarea (label from `MediaCrowdriffMediaForm`).
4. To size the output, edit the media type's **Manage display** and configure the
   **Media Crowdriff** formatter's *Width* / *Height* (CSS units, e.g. `640px`, `100%`).

## Via drush php:eval (scriptable)

```php
use Drupal\media\Entity\MediaType;
$type = MediaType::create([
  'id' => 'crowdriff', 'label' => 'Crowdriff', 'source' => 'media_crowdriff',
]);
$type->save();
// Core helper builds the string_long source field (field_media_media_crowdriff):
$field = $type->getSource()->createSourceField($type);
$field->getFieldStorageDefinition()->save();
$field->save();
$type->set('source_configuration', ['source_field' => $field->getName()])->save();
```

Create a Crowdriff asset:

```php
use Drupal\media\Entity\Media;
$m = Media::create([
  'bundle' => 'crowdriff', 'name' => 'My gallery',
  'field_media_media_crowdriff' => '<div id="cr-init__abcd1234"></div>',
]);
$m->save();   // validate() enforces the Crowdriff-id regex; invalid codes are rejected.
```

## Read it back

```bash
drush php:eval '$t=\Drupal\media\Entity\MediaType::load("crowdriff");
print $t->getSource()->getPluginId()."\n";                       // media_crowdriff
print $t->getSource()->getSourceFieldDefinition($t)->getName();  // field_media_media_crowdriff'
```

Or inspect the display component:
`drush cget core.entity_view_display.media.crowdriff.default content.field_media_media_crowdriff`
— look for `type: media_crowdriff` and `settings.width` / `settings.height`.

## What the pieces are

- **Source field** — a `string_long` field holding the raw Crowdriff embed code.
- **Validation** — the `media_crowdriff` constraint (added via
  `MediaCrowdriffSource::getSourceFieldConstraints()`) rejects values that lack a Crowdriff id
  (`empty` → "The embed code cannot be empty."; no `cr-init__…`/`cr__init-…` → invalid message).
- **Formatter** — `media_crowdriff` (id), for `string_long` fields, settings `width`=`100%`,
  `height`=`900px`. Set them on the view display to change the rendered iframe/script size.
