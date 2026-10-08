<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Marker data model, drag/resize editing, and rendering

## The `dme_marker` paragraph type

Config-installed Paragraphs type `dme_marker` (label *Map Marker*,
`paragraphs.paragraphs_type.dme_marker.yml`). It is the target bundle of the entity's
`field_dme_marker` (`entity_reference_revisions`, unlimited). Fields (config/install):

| Field | Type | Required | Notes |
|---|---|---|---|
| `field_dme_marker_title` | string | yes | Marker label / tooltip text. |
| `field_dme_marker_description` | text_long | no | Rich text; shown in a modal on display. |
| `field_dme_marker_icon` | image | no | Optional icon; extensions `png gif jpg jpeg`, dir `draggable_map/markers/[date:custom:Y]-[date:custom:m]`, `alt_field_required: true`. If empty, the title text is used as the marker. |
| `field_dme_marker_x` | decimal (10,6) | no | Horizontal position as a **fraction 0–1** of the container. |
| `field_dme_marker_y` | decimal (10,6) | no | Vertical position, fraction 0–1. |
| `field_dme_marker_width` | decimal (10,6) | no | Width as fraction of container. |
| `field_dme_marker_height` | decimal (10,6) | no | Height as fraction of container. |

A marker with a null/empty `x` **or** `y` is "unmapped" (not yet placed) and is skipped on
display.

## Editing: how coordinates are captured

`DraggableMapperForm::addPreviewContainer()` (`src/Form/DraggableMapperForm.php`):

- Sets each marker subform's `field_dme_marker_x/_y/_width/_height` widget `#type` to `hidden`
  (editors never type coordinates).
- Builds a `dme_preview_container` render array: a `dme-image` surface showing the uploaded image
  (`getImageFid()` resolves the file id from the AJAX upload / form state / default value, then
  `fileUrlGenerator->generateString()`), a `dme-unmapped-wrapper` for un-placed markers and a
  `dme-container-wrapper` for placed ones. `getMarkerData()` reads each marker's title/icon and,
  for saved entities, loads the referenced paragraph to read stored x/y/width/height.
- Mapped markers get an inline `style="left: {x*100}%; top: {y*100}%; …"`.

`js/draggable_mapper.form.js` (library `draggable_mapper/draggable_mapper.form`,
jQuery UI draggable/droppable/resizable):

- `initDraggableMarkers()` makes each `.dme-marker` draggable; on drop inside
  `.dme-container-wrapper` it computes `posX = relativeX / containerWidth` (6-dp fraction) and
  writes it into the paragraph's `input[name*="field_dme_marker_x"]` / `_y`, firing `change`.
- `makeMarkerResizable()` resizes markers and writes `field_dme_marker_width` / `_height`
  fractions on resize-stop.
- Title/icon behaviors keep the preview chip in sync with the subform's title input and icon
  upload (icon preview via `FileReader` data URL). Save persists everything through normal
  Paragraphs/IEF entity saving; `DraggableMapperForm::save()` shows a status message and redirects
  to the collection.

## Rendering: preprocess + template

`hook_theme()` registers `draggable_mapper` → `templates/draggable-mapper.html.twig`;
`template_preprocess_draggable_mapper()` delegates to
`DraggableMapperPreprocessHook::preprocessDraggableMapper()`
(`src/PreprocessHooks/DraggableMapperPreprocessHook.php`):

- Sets `title` / `label` from `$entity->label()`, adds `draggable-mapper*` classes, resolves
  `map_image_url` + `map_alt` from `field_dme_image`.
- Iterates `field_dme_marker->referencedEntities()`; **skips** markers missing x/y (and skips when
  width/height fields exist but are empty). For each kept marker it builds `x`/`y` (and
  width/height) as **percentages** (`value * 100`), `title`
  (`field_dme_marker_title`, else fallback `Marker N`), an optional `description` render array
  (`#type => 'processed_text'` with the field's stored text format), and optional
  `icon_url`/`icon_alt`.
- Attaches library `draggable_mapper/draggable_mapper.view`.

`templates/draggable-mapper.html.twig` renders an `<h1>` (full view mode) / `<h2>` title, the
`.dme-image` `<img>`, and one absolute-positioned `.dme-marker` div per marker (icon `<img>` or
title text). Markers with a description also emit a hidden `.dme-marker-modal` block containing the
`{{ marker.description }}` render array.

`js/draggable_mapper.view.js` (`Drupal.behaviors.draggableMapperView`): sizes marker font to the
marker box, and for markers flagged `data-has-description="true"` wires click → open the matching
`#dme-marker-modal-{id}` modal (Escape / close button / outside-click all close it). Markers
without a description just toggle an active class on click.
