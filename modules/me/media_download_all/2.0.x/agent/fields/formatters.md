<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The four "(MDA)" entity-reference formatters

## Install & enable

```bash
composer require drupal/media_download_all
drush en media_download_all -y
```

Only dependency is core **`media`**. No sub-modules, no permissions of its own, no Drush commands,
no settings form.

## The plugins

All live in `src/Plugin/Field/FieldFormatter/`, all declare `field_types = {"entity_reference"}`,
and all do the same thing: call `parent::viewElements()` then
`MdaFormatterTrait::appendMdaLink($elements, $items, $langcode)`.

| Plugin id | Label | Extends (core) |
|---|---|---|
| `media_download_all_thumbnail` | Thumbnail (MDA) | `MediaThumbnailFormatter` |
| `media_download_all_entity_view` | Rendered entity (MDA) | `EntityReferenceEntityFormatter` |
| `media_download_all_label` | Label (MDA) | `EntityReferenceLabelFormatter` |
| `media_download_all_entity_id` | Entity ID (MDA) | `EntityReferenceIdFormatter` |

Because each extends a core formatter, every setting of the parent formatter is inherited (image
style for Thumbnail, view mode for Rendered entity, link-to-entity for Label, etc.). The only added
behavior is the appended link.

## Config schema

`config/schema/media_download_all.schema.yml` maps each formatter's settings onto the parent
formatter's schema:

- `field.formatter.settings.media_download_all_entity_view` → extends `...entity_reference_entity_view`.
- `field.formatter.settings.media_download_all_thumbnail` → extends `...image`.
- `field.formatter.settings.media_download_all_entity_id` → empty mapping.
- `field.formatter.settings.media_download_all_label` → mapping with `link` (boolean, "Link label to the referenced entity").

## Enable on a field (UI)

The field must be an **entity-reference field** (normally targeting **media**). Go to
*Structure → (bundle) → Manage display*, set that field's format to one of the four
"… (MDA)" formats, and configure the inherited settings via the gear.

Drush / config equivalent (view display):

```bash
drush cset core.entity_view_display.node.article.default \
  content.field_media.type media_download_all_thumbnail -y
drush cr
```

## The appended link (`MdaFormatterTrait::appendMdaLink`, `src/Traits/MdaFormatterTrait.php`)

- Returns the elements unchanged if the field render array is empty (empty field → no link).
- Reads `$items->getName()` (field name), and the host entity's type id and id.
- Builds `Url::fromUserInput("/media_download_all/$entity_type/$entity_id/$field_name")` — a fixed
  internal path assembled from the host entity's own identifiers, not from request input.
- Appends `Link::fromTextAndUrl('Download All Files', $url)->toRenderable()` with CSS class
  `media-download-all` as a new element after the field values.

The link text "Download All Files" is hardcoded (not translated, not configurable). The link points
at the download route documented in [../api/download.md](../api/download.md), which performs the
actual access check, media walk, ZIP build and streaming.
