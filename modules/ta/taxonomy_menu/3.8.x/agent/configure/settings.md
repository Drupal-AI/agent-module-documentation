# Configure a Taxonomy Menu

A **`taxonomy_menu`** configuration entity maps one vocabulary to one menu and generates a
menu link per term. Manage them at Admin → Structure → Taxonomy menu.

## Routes (all require core `administer site configuration`)

| Route | Path | Purpose |
|---|---|---|
| `entity.taxonomy_menu.collection` | `/admin/structure/taxonomy_menu` | List taxonomy menus (the `configure` route) |
| `entity.taxonomy_menu.add_form` | `/admin/structure/taxonomy_menu/add` | Add a taxonomy menu |
| `entity.taxonomy_menu.edit_form` | `/admin/structure/taxonomy_menu/{taxonomy_menu}` | Edit |
| `entity.taxonomy_menu.delete_form` | `/admin/structure/taxonomy_menu/{taxonomy_menu}/delete` | Delete |
| `taxonomy_menu.test` | `/taxonomy-menu/render-taxonomy-links` | Debug: render taxonomy links |

The module defines **no permissions of its own**; access uses the core
`administer site configuration` permission (also the entity's `admin_permission`).

## Config entity fields (`config_export`, schema `config/schema/taxonomy_menu.schema.yml`)

| Key | Type | Meaning |
|---|---|---|
| `id` | string | Machine name of the taxonomy menu |
| `label` | label | Human label |
| `vocabulary` | string | Machine name of the source vocabulary (terms become links) |
| `menu` | string | Machine name of the target menu the links are added to |
| `depth` | integer | Max term depth to generate (form offers 1-9); tree loaded to `depth + 1` |
| `expanded` | boolean | Render all generated entries expanded |
| `menu_parent` | string | Parent menu link the generated tree hangs under |
| `description_field_name` | string | Term field whose value is used as the menu-item description (`''`/none allowed) |
| `use_term_weight_order` | boolean | Order items by term weight (default TRUE); otherwise alphabetical |

The entity adds config dependencies on `system.menu.{menu}` and
`taxonomy.vocabulary.{vocabulary}` in `preSave()`. Being a config entity, a taxonomy menu
exports/deploys with `drush config:export` / `config:import`.

## How links are built and synced

- **On save** (`TaxonomyMenu::save()`): loads the vocabulary tree, builds one menu link
  plugin definition per term, and adds/updates each definition in the core menu link
  manager. Term parent relationships set each link's `parent`.
- **On delete** (`TaxonomyMenu::delete()`): removes every generated link definition.
- **On term changes**: `hook_taxonomy_term_insert/update/delete` in `taxonomy_menu.module`
  call the `taxonomy_menu.helper` service to add/update/remove just that term's link, so the
  menu stays in sync automatically.
- Titles and descriptions are rendered **dynamically from the term** (and its active
  translation) by the menu link plugin — they are not stored, so they always match the
  taxonomy. A link is disabled automatically when its term's `status` is unpublished.

## Constraints (by design)

Generated menu items are decoupled once created, but the menu link plugin only allows
overriding `weight`, `expanded`, `enabled`, and `parent` (see `$overrideAllowed`). Titles,
descriptions, menu name, and metadata are locked to keep the menu resembling the taxonomy.
Menu items are heavily cached — clear caches after bulk term/menu changes.
