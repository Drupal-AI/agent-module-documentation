<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `draggable_mapper` entity: type, fields, routes, permissions

## Install & enable

```bash
composer require drupal/draggable_mapper
drush en draggable_mapper -y
```

Pulls in Paragraphs, Inline Entity Form, Entity Reference Revisions and the three jQuery UI
modules (draggable/droppable/resizable) plus core field/image/text. `hook_install`
(`draggable_mapper.install`) clears the discovery/config/render caches and, via
`_draggable_mapper_remove_conflicting_configs()`, deletes two leftover configs from an old data
model (`core.entity_form_display.node.reference_mapping.default`,
`field.field.node.reference_mapping.field_draggable_map`). Uninstall drops the entity, paragraph
and legacy node field tables and all module config.

## The entity type

`src/Entity/DraggableMapper.php` — `@ContentEntityType`:

- `id = "draggable_mapper"`, `base_table = "draggable_mapper"`, one implicit bundle
  (`draggable_mapper`). Implements `EntityOwnerInterface`, uses `EntityOwnerTrait` +
  `EntityChangedTrait`.
- `admin_permission = "administer draggable mapper"`; `field_ui_base_route =
  entity.draggable_mapper.collection` (Field UI *Manage fields/form/display* tabs hang off the
  collection route).
- Handlers: core `EntityViewBuilder`, `EntityViewsData`; module `DraggableMapperListBuilder` and
  `DraggableMapperAccessControlHandler`; forms `default`/`add`/`edit` =
  `Drupal\draggable_mapper\Form\DraggableMapperForm`, `delete` = core
  `ContentEntityDeleteForm`; `route_provider.html` = core `AdminHtmlRouteProvider`.
- `entity_keys`: `id`, `label = name`, `uuid`, `owner = uid`.

### Base fields (`baseFieldDefinitions()`)

| Field | Type | Notes |
|---|---|---|
| `name` | string (max 255, required) | The map label (entity `label` key). |
| `created` | created | Creation timestamp. |
| `changed` | changed | Last-edited timestamp. |
| `uid` | (owner) | From `EntityOwnerTrait::ownerBaseFieldDefinitions()`. |

### Bundle fields (config/install)

- **`field_dme_image`** — image, **required**. Background map image. `file_directory:
  draggable_mapper/maps`, `alt_field_required: true`, allowed extensions
  `png jpg jpeg gif svg`.
- **`field_dme_marker`** — `entity_reference_revisions`, **cardinality -1** (unlimited),
  `target_type: paragraph`, `target_bundles: {dme_marker}`. The markers. Marker paragraph model,
  editing JS and rendering are in [../theme/markers-and-rendering.md](../theme/markers-and-rendering.md).

## Routes (from `AdminHtmlRouteProvider` + `links`)

| Route id | Path | Operation / access |
|---|---|---|
| `entity.draggable_mapper.canonical` | `/draggable-mapper/{draggable_mapper}` | view |
| `entity.draggable_mapper.add_form` | `/admin/structure/draggable-mapper/add` | create |
| `entity.draggable_mapper.edit_form` | `/admin/structure/draggable-mapper/{draggable_mapper}/edit` | update |
| `entity.draggable_mapper.delete_form` | `/admin/structure/draggable-mapper/{draggable_mapper}/delete` | delete |
| `entity.draggable_mapper.collection` | `/admin/structure/draggable-mapper` | `administer draggable mapper` |

Menu link `draggable_mapper.collection` (`*.links.menu.yml`) puts the collection under
*Structure*; action link `draggable_mapper.add_form` (`*.links.action.yml`) adds an "Add Draggable
Mapper" button on the collection. `DraggableMapperListBuilder` lists ID + name (name links to the
canonical route).

> Note: the drupal.org project text mentions `/admin/structure/draggable-mapper-entity/add`; the
> actual annotation route is `/admin/structure/draggable-mapper/add` (verify in source, not the
> project page).

## Permissions & access model

`draggable_mapper.permissions.yml` defines five permissions; `DraggableMapperAccessControlHandler`
(`checkAccess` / `checkCreateAccess`) maps operations to them with
`AccessResult::allowedIfHasPermission()`:

| Operation | Permission |
|---|---|
| view | `view draggable mapper` |
| update | `edit draggable mapper` |
| delete | `delete draggable mapper` |
| create | `add draggable mapper` |
| (Field UI / collection) | `administer draggable mapper` (`restrict access: true`) |

Access is **permission-based, not owner-scoped**: any account holding a given permission can
view/edit/delete **all** maps regardless of the `uid` owner. `unpublished` status is not modeled
(no `status` key); a map is visible to anyone with `view draggable mapper`.

## Create a map (operating it)

1. *Structure → Draggable Mapper → Add Draggable Mapper*
   (`/admin/structure/draggable-mapper/add`).
2. Enter **Name**, upload a **Map Image** (`field_dme_image`).
3. Under **Markers**, click *Add Marker* (Paragraphs, inline) — fill **Title** (required),
   optional **Description** (rich text) and **Icon** image.
4. In the **Map Preview** that `DraggableMapperForm::addPreviewContainer()` renders, drag each
   marker chip onto the image and resize it; the JS writes x/y/width/height into the (hidden)
   coordinate fields.
5. Save → redirects to the collection; view at `/draggable-mapper/{id}`.

Maps can be embedded elsewhere by adding an entity-reference field targeting `draggable_mapper`;
when such a form is rendered inline via IEF, `hook_inline_entity_form_entity_form_alter()`
re-attaches the `draggable_mapper/draggable_mapper.form` library and the preview container.
