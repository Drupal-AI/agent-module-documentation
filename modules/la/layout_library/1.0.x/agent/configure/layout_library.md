# Configure Layout Library

Beta. Requires core **Layout Builder** enabled. No `*.routing.yml`, no settings form — routes come
from the `layout` config entity's route provider plus the `layout_library` section-storage plugin.

## 1. Create reusable layouts (the library)

Admin UI: **Admin → Structure → Layout library** (`entity.layout.collection`, `/admin/structure/layouts`).
This is the `configure` route from `layout_library.info.yml`.

Config-entity routes (from `AdminHtmlRouteProvider`, gated by `configure any layout`):

| Route | Path | Purpose |
|---|---|---|
| `entity.layout.collection` | `/admin/structure/layouts` | List all library layouts |
| `entity.layout.add_form` | `/admin/structure/layouts/add` | Add a layout |
| `entity.layout.delete_form` | `/admin/structure/layouts/manage/{layout}/delete` | Delete a layout |

Add flow (`LayoutAddForm`): enter a **Label**, a machine **id**, and pick an **Entity Type** —
a select of every content entity type + bundle as `"{entity_type}:{bundle}"`, stored as the layout's
`targetEntityType` / `targetBundle`. On save you are redirected to that layout's Layout Builder UI to
arrange sections/blocks (route `layout_builder.layout_library.{entity_type}.view`, path is the bundle's
manage-display path + `/layout-library/{layout}`, gated by `administer {entity_type} display`).

The `layout` config entity (`config_prefix: layout`, so config files are `layout_library.layout.{id}.yml`)
exports `id, label, targetEntityType, targetBundle, layout`, where `layout` is a sequence of
`layout_builder.section` items. Because it is config, layouts deploy via `drush config:export`/`import`.

## 2. Enable the library on a bundle's Layout Builder display

On a bundle's **Manage display** for a view mode where **Layout Builder is already enabled**, the module's
`hook_form_..._alter` adds a checkbox:

> **"Allow content editors to use stored layouts"** — stored as the third-party setting
> `core.entity_view_display.{entity}.{bundle}.{view_mode}` → `third_party.layout_library.enable` (boolean).

When enabled (see `LayoutLibraryHooks::entityViewDisplayUpdate`), the module automatically:

- creates a **locked** `layout_selection` entity-reference field storage (`target_type: layout`) if absent;
- adds a `layout_selection` field (label "Layout") to the bundle using the `layout_library` selection handler;
- adds that field to the bundle's **default form display** — widget `options_select` if the `options`
  module is enabled, otherwise `entity_reference_autocomplete`.

Unticking it removes the `layout_selection` field/widget from that bundle (only once no other view mode
of the same bundle still has it enabled).

## 3. Authors pick a saved layout

On the content add/edit form the author uses the **Layout** (`layout_selection`) select. The
`layout_library` `EntityReferenceSelection` plugin filters options to only `layout` entities whose
`targetEntityType`/`targetBundle` match the entity being edited. When the item's Layout Builder override
has not yet been customized, the `PrepareLayout` event subscriber (priority 20 on
`LayoutBuilderEvents::PREPARE_LAYOUT`) copies the selected library layout's sections onto the entity as the
starting point, which the author may then override further.

Key internals: `Layout` config entity (`SectionListInterface`); `Library` section-storage plugin
(id `layout_library`); `LayoutStorageHandler` (serializes sections to/from config). No submodules, no
Drush commands.
