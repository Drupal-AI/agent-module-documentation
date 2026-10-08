# Configure config pages (types, fields, context)

Two entity types: `config_pages_type` (config entity, the "bundle"/definition) and
`config_pages` (content entity, the actual stored values — one per type per context).

## Admin routes (all under `/admin/structure/config_pages`)

| Route | Path | Purpose / permission |
|---|---|---|
| `entity.config_pages.collection` | `/admin/structure/config_pages` | Config pages library (the `configure` route); `edit config_pages entity` + `access config_pages overview` |
| `config_pages.type_add` | `/types/add` | Add a config page **type**; `administer config_pages types` |
| `entity.config_pages_type.collection` | `/types` | List types; `administer config_pages types` |
| `entity.config_pages_type.edit_form` | `/types/manage/{type}` | Edit type (also the Field UI base route) |
| `entity.config_pages_type.delete_form` | `/types/manage/{type}/delete` | Delete type |
| `entity.config_pages.canonical` | `/admin/structure/config_pages/{config_pages}` | Edit the stored singleton (`config_pages.update`) |
| `entity.config_pages.clear_confirmation` | `/{config_pages}/confirmPurge` | Purge all values; `access config_pages clear values option` |
| `entity.config_pages.import_confirmation` | `/{config_pages}/confirmImport/{imported_entity_id}` | Import values from another context; `context import config_pages entity` |

When a type defines a **menu path** the module also registers a route
`config_pages.{type}` at that path (see `ConfigPagesRoutes::routes` / `toUrl()`).

## Workflow

1. Go to `/admin/structure/config_pages` → **Add config page** and create a type: give it a
   label, an optional menu `path`/`weight`/`description`, choose context, and toggle **token**
   exposure.
2. The type is a bundle of `config_pages`, so add fields to it via **Field UI** on the type
   edit form (`entity.config_pages_type.edit_form` is `field_ui_base_route`). Use **Manage
   display** if the page will be rendered/placed as a block.
3. Edit the actual page (the `config_pages` entity) — a singleton per type+context — from the
   library or its menu path. `ConfigPages::config($type, $context)` resolves the right one.

## Config page TYPE settings (config entity `config_pages_type`)

Exported keys (`config_pages.type.*`, schema `config/schema/config_pages.schema.yml`):

| Key | Meaning |
|---|---|
| `id`, `label` | Machine name / human label |
| `token` | Boolean — expose this type's field values as `[config_page:*]` tokens |
| `menu.path` / `menu.weight` / `menu.description` | Optional custom mount point in the menu system |
| `context.group` | Map of `context_id => bool` — which context plugins are active for this type |
| `context.fallback` | Per-context fallback values (e.g. a default language) |
| `context.show_warning` | Boolean — warn editors that values are context-specific |

## Context (per-language / per-domain / custom)

Enabling a context on a type makes the module store a **separate `config_pages` entity per
context value** (the value is serialized into the entity's `context` field). A **Language**
context ships in the box (`Plugin/ConfigPagesContext/Language.php`, id `language`) — enable it
to get distinct settings per content language, with an optional fallback language. Add your own
context by implementing the `config_pages_context` plugin type (see `api/config_pages.md`).
`getContextData()` computes the hash used to load the correct singleton; `config()` falls back
to the fallback context and then an empty-context entity when no exact match exists.

Config page **types** are configuration (`drush config:export` / import them between
environments); the stored **values** are content, not exported.
