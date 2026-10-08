<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Draggable Mapper (draggable_mapper) — agent index

Defines a custom **content entity type `draggable_mapper`**: a background image plus interactive,
drag-placed, resizable markers. Package `Custom`. Core `^9 || ^10 || ^11`, PHP `>=8.1`. License
GPL-2.0-or-later. Documented at 1.1.3 (version dir 1.1.x).

Hard dependencies (info.yml): core `field`, `image`, `text`; contrib `paragraphs`,
`inline_entity_form`, `entity_reference_revisions` (via composer), `jquery_ui_draggable`,
`jquery_ui_droppable`, `jquery_ui_resizable`. No settings form, no Drush, no config schema, no
plugin types.

- **The entity type, its fields, CRUD routes, permissions and how to create a map** →
  [entity/draggable-mapper.md](entity/draggable-mapper.md)
- **The marker data model (dme_marker paragraph), drag/resize JS, preprocess + Twig rendering** →
  [theme/markers-and-rendering.md](theme/markers-and-rendering.md)

## What it actually is (from source)

- One content entity: `Drupal\draggable_mapper\Entity\DraggableMapper`
  (`src/Entity/DraggableMapper.php`), `@ContentEntityType id = "draggable_mapper"`,
  `base_table = "draggable_mapper"`, single implicit bundle `draggable_mapper`,
  `admin_permission = "administer draggable mapper"`, `EntityOwnerTrait` + `EntityChangedTrait`.
  Base fields: `name` (label), `created`, `changed`, `uid` (owner).
- Routes come from core `AdminHtmlRouteProvider` + the entity `links` annotation:
  canonical `/draggable-mapper/{draggable_mapper}`, add `/admin/structure/draggable-mapper/add`,
  edit `.../{id}/edit`, delete `.../{id}/delete`, collection `/admin/structure/draggable-mapper`
  (menu link *Structure → Draggable Mapper*, `field_ui_base_route`).
- Access: `DraggableMapperAccessControlHandler` maps view/update/delete/create to the four
  non-admin permissions in `draggable_mapper.permissions.yml`.
- Bundle fields (config/install): `field_dme_image` (required image, background) and
  `field_dme_marker` (unlimited `entity_reference_revisions` → paragraph type `dme_marker`).
- `dme_marker` paragraph fields: `field_dme_marker_title` (string, required),
  `field_dme_marker_description` (text_long), `field_dme_marker_icon` (image),
  `field_dme_marker_x` / `_y` / `_width` / `_height` (decimal 10,6 — fractions 0–1).
- Form controller `DraggableMapperForm` builds a live "Map Preview", hides the coordinate fields,
  and renders draggable marker chips; `js/draggable_mapper.form.js` writes drag/resize results into
  the hidden coordinate inputs. `hook_inline_entity_form_entity_form_alter` attaches the same
  preview when the entity is embedded via IEF.
- Display: `hook_theme` `draggable_mapper` → `templates/draggable-mapper.html.twig`,
  preprocessed by `DraggableMapperPreprocessHook::preprocessDraggableMapper`;
  `js/draggable_mapper.view.js` opens per-marker modals.
- `.install`: `hook_install`/`hook_uninstall` clear caches and drop the entity/paragraph/node field
  tables and config; `draggable_mapper_update_8001` repairs a missing entity-definition state.

## Permissions (draggable_mapper.permissions.yml)

`administer draggable mapper` (restrict access), `add draggable mapper`, `view draggable mapper`,
`edit draggable mapper`, `delete draggable mapper`. See entity doc for the operation mapping.
