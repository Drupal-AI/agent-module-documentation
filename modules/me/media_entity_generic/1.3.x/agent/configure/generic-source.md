<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Create a media type using the Generic source

The module adds no configuration of its own — you consume its source plugin when creating a
**media type** (`media_type` config entity).

## Via the UI

1. Go to *Structure → Media types → Add media type* (`/admin/structure/media/add`).
2. Set a name; in **Media source** choose **Generic media**.
3. Save. Core creates a `string` source field (the Generic source's only allowed field type).

The resulting config `media.type.<id>` has:

```yaml
source: generic
source_configuration:
  source_field: field_media_<something>
```

## Via the API (scriptable)

`generic`'s only allowed field type is `string`. Create the type, then create + wire its source
field (Media does not auto-create it outside the form):

```php
use Drupal\media\Entity\MediaType;

$type = MediaType::create([
  'id' => 'reference_code',
  'label' => 'Reference code',
  'source' => 'generic',
]);
$type->save();

// Let the source build its string source field, then persist + link it.
$source = $type->getSource();
$field = $source->createSourceField($type);          // a 'string' field
$field->getFieldStorageDefinition()->save();
$field->save();
$type->set('source_configuration', ['source_field' => $field->getName()])->save();
```

## Read it back

```bash
drush config:get media.type.reference_code source            # -> generic
drush config:get media.type.reference_code source_configuration
```

Or in PHP: `\Drupal\media\Entity\MediaType::load('reference_code')->getSource()->getPluginId()`
returns `generic`.

## Plugin characteristics an agent should know

- `getMetadataAttributes()` returns `[]` — the Generic source surfaces **no** derived metadata,
  so there are no source-provided fields to map (e.g. no width/height/duration).
- `createSourceFieldStorage()` sets `custom_storage = TRUE` on the field storage.
- Default thumbnail is `generic.png`; media of this type share one generic preview image.
- `allowed_field_types = {"string"}`, so the source field is always a plain text string.
