<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Slideshow media source, ItemsCount constraint, duplicates checksum

Three related plugins in the base module. All are ported "in large parts" from
`media_entity_slideshow` (per their docblocks). They power the `slideshow` media type that the
`drowl_media_types` submodule installs (source field `field_media_slides_ref`, an entity_reference
to other media).

## Slideshow media source

`src/Plugin/media/Source/Slideshow.php` — `@MediaSource(id="slideshow", label="Slideshow",
default_thumbnail_filename="slideshow.png", allowed_field_types={"entity_reference"})`, extends
`MediaSourceBase` and implements `MediaSourceEntityConstraintsInterface`. It is a **plugin instance**
of core's media-source plugin type, not a new plugin type.

Key methods:

- `getMetadataAttributes()` → exposes one attribute, `length`.
- `getMetadata($media, $name)`:
  - `length` → `$media->{source_field}->count()` (number of referenced slides).
  - `default_name` → `formatPlural(length, 'Slideshow: 1 slide', 'Slideshow: @count')`, else parent.
  - `thumbnail_uri` → loads the **first referenced** media item, asks *its* bundle's source for a
    `thumbnail_uri`, and reuses it (falls back to parent at each empty step).
- `getSourceFieldValue($media)` → returns the whole field item **list** (not a scalar), because a
  slideshow is represented by many slides; throws `RuntimeException` if `source_field` is unset,
  returns `NULL` when empty.
- `getEntityConstraints()` → `['ItemsCount' => ['sourceFieldName' => $source_field]]`.

Config schema `media.source.slideshow` extends `media.source.field_aware` (schema file
`config/schema/drowl_media.schema.yml`). The source field is set by config/update hooks to
`field_media_slides_ref`.

Because the `slideshow` source provides no upload/create widget of its own, `drowl_media.module`
adds a **"Create new Slideshow"** link (`drowl_media_field_widget_single_element_media_library_widget_form_alter()`)
beside the media-library reference widget, and relabels the add button to "Select Slideshow".

## ItemsCount validation constraint

`src/Plugin/Validation/Constraint/ItemsCountConstraint.php` — `@Constraint(id="ItemsCount",
label="Slideshow items count")`, public `$sourceFieldName` and `$message = 'At least one slideshow
item must exist.'`.

`ItemsCountConstraintValidator::validate($value, $constraint)` — if the entity's
`$constraint->sourceFieldName` field `isEmpty()`, adds the violation. Wired in via the source's
`getEntityConstraints()`, so saving a slideshow with no slides is rejected.

## MediaDuplicatesChecksum plugin

`src/Plugin/MediaDuplicatesChecksum/Slideshow.php` — `@MediaDuplicatesChecksum(id="slideshow",
media_types={"slideshow"})`, extends `MediaDuplicatesChecksumBase` (from the optional contrib
`media_duplicates` module; only active when that module is installed).

`getChecksumData(Media $media)` → gets the source field value list via the source plugin, calls
`referencedEntities()`, and returns the referenced slides' UUIDs **pipe-joined in list order**
(e.g. `uuidA|uuidB`). Two slideshows referencing the same slides in the same order collide as
duplicates; a different order yields a different checksum. (A `@todo` notes future support for
extra conditions per issue #3305117.)
