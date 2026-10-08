<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `image_style_uri` computed field

## What the module adds

`jsonapi_image_styles_entity_base_field_info()` (in the `.module`) adds one **computed base
field** to the **File** entity type only (it checks `$entity_type->getOriginalClass() ===
'Drupal\file\Entity\File'`):

- Field name: **`image_style_uri`**
- Field type: `image_style_uri` (an internal `no_ui` map field defined by the module, subclassing
  core `MapItem`; list class `ImageStyleNormalizedFieldItemList`).
- Computed (`->setComputed(TRUE)`), cardinality 1, translatable.

Because it is a base field on File, JSON:API automatically serializes it into every
`file--file` resource's `attributes`.

## Value / response shape

`ImageStyleNormalizedFieldItemList::computeValue()`:

1. Loads `jsonapi_image_styles.settings`.
2. Only computes when the file's MIME type starts with `image` (`substr($mime,0,5) === 'image'`);
   non-image files get no value.
3. Picks the styles to expose (the selected allow-list, or all styles if none selected — see
   [../configure/settings.md](../configure/settings.md)).
4. For each style, calls `ImageStyle::buildUrl($fileUri)` and returns a **map** keyed by style id.

So the serialized attribute looks like:

```json
"attributes": {
  "image_style_uri": {
    "thumbnail": "https://example.com/sites/default/files/styles/thumbnail/public/cat.jpg",
    "large": "https://example.com/sites/default/files/styles/large/public/cat.jpg"
  }
}
```

## Consuming it from a decoupled client

Include the image file resource in your request and read `image_style_uri` off the file:

```
GET /jsonapi/node/article/{uuid}?include=field_image
# → the included file--file resource carries attributes.image_style_uri
```

For media fields, walk to the file, e.g. `?include=field_media_image` on a `media--image` request,
then read `image_style_uri` on the included `file--file`.

## Cheap check on the running site

```bash
# Confirm the base field exists on File:
drush php:eval '$d=\Drupal::service("entity_field.manager")->getBaseFieldDefinitions("file"); var_dump(isset($d["image_style_uri"]));'
```

## Notes / limits

- The field is **read-only / computed**; you cannot set it.
- It builds URLs, it does not force derivative generation — the derivative is created by Drupal when
  the style URL is first requested (standard image-style behaviour).
- No config schema ships for `image_style_uri`; it is `no_ui` and not meant to be attached manually.
