# Configuring Micro-content

No global settings form (`configure` = null). "Configuration" = creating micro-content **types** and
attaching fields.

## Entities
- **`microcontent_type`** (config bundle, `ConfigEntityBundleBase`) — `config_prefix: type`, so config
  objects are `microcontent.type.<id>`. Exported keys (`config_export`): `name`, `id`, `description`,
  `type_class`, `new_revision`.
  - `type_class` — free "Background class" string rendered onto the entity in
    `templates/microcontent.html.twig`.
  - `new_revision` (bool) — whether saving an item of this type creates a new revision by default.
- **`microcontent`** (content entity) — the fieldable item; bundle = its type.

## Admin routes
| Purpose | Path | Route |
|---|---|---|
| Type list | `/admin/structure/microcontent-types` | `entity.microcontent_type.collection` |
| Add type | `/admin/structure/microcontent-types/add` | `entity.microcontent_type.add_form` |
| Edit type | `/admin/structure/microcontent-types/manage/{microcontent_type}` | `entity.microcontent_type.edit_form` |
| Item list | `/admin/content/microcontent` | `entity.microcontent.collection` |
| Add item (chooser) | `/admin/content/microcontent/add` | `entity.microcontent.add_page` |
| Add item of type | `/admin/content/microcontent/add/{microcontent_type}` | `entity.microcontent.add_form` |
| Edit item | `/admin/content/microcontent/{microcontent}/edit` (canonical) | `entity.microcontent.canonical` |

Because `field_ui_base_route = entity.microcontent_type.edit_form`, Field UI (when enabled) adds
*Manage fields / form display / display* tabs to each type.

## Config schema
`config/schema/microcontent.schema.yml` defines `microcontent.type.*` (`name`, `id`, `description`,
`type_class`, `new_revision`).

## Shipped optional config (`config/optional/`, installs if deps present)
- `entity_browser.browser.microcontent` — an Entity Browser named `microcontent` for selecting items.
- `views.view.micro_content_admin` — the admin overview View.
- `views.view.microcontent_browser` — the browser View (its render attaches the
  `microcontent/entity-browser` library via `hook_preprocess_views_view`).
- `core.entity_form_mode.microcontent.entity_browser` and `core.entity_view_mode.microcontent.preview`.

## Create a type via Drush
```bash
drush php:eval "\Drupal::entityTypeManager()->getStorage('microcontent_type')->create([
  'id' => 'promo', 'name' => 'Promo', 'new_revision' => TRUE, 'type_class' => 'is-promo',
])->save();"
```
