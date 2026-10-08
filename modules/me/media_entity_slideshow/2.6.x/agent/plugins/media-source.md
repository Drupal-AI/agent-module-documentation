<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `slideshow` media source plugin

`Drupal\media_entity_slideshow\Plugin\media\Source\Slideshow` (extends core `MediaSourceBase`,
implements `MediaSourceEntityConstraintsInterface`).

```php
@MediaSource(
  id = "slideshow",
  label = @Translation("Slideshow"),
  description = "Provides business logic and metadata for slideshows.",
  default_thumbnail_filename = "slideshow.png",
  allowed_field_types = {"entity_reference"},
)
```

So a media type using this source must map its `source_field` to an **`entity_reference`** field
(the slides — typically referencing `media`, multi-value/ordered).

## Metadata attributes (`getMetadata()`)

- `length` — number of slides: `$media->{source_field}->count()`.
- `default_name` — when the media has no name, produces
  `"1 slide, created on <date>"` / `"<N> slides, created on <date>"` (date = the media's created
  time in `Y-m-d\TH:i:s`). Falls back to the parent default name when `length` is empty.
- `thumbnail_uri` — the **first** referenced slide's own `thumbnail_uri` (loads the first
  referenced media, asks its source for `thumbnail_uri`); falls back to the module's
  `slideshow.png` icon if there is no first slide / thumbnail.

`getMetadataAttributes()` advertises just `length` ("Slideshow length") to the media type UI for
field mapping.

## Validation constraint

`getEntityConstraints()` returns `['ItemsCount' => ['sourceFieldName' => <source_field>]]`.

- Constraint `ItemsCount` (`Drupal\media_entity_slideshow\Plugin\Validation\Constraint\ItemsCountConstraint`)
  — validator adds a violation when the source field is empty. Default message:
  **"At least one slideshow item must exist."** So a slideshow media entity must have ≥1 slide.

## What it does not do

No carousel rendering, JS, or display formatter is provided — the plugin supplies the media model,
metadata, and validation only. Theme the slides (a Views/field formatter or a JS carousel library)
yourself.
