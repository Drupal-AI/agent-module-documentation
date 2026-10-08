# config_pages — agent start

Fieldable "singleton" pages for site-wide settings. A `config_pages` **content entity** whose
bundles are `config_pages_type` **config entities**; you add Field UI fields to a type and edit
one shared entity instead of coding a settings form. Context-aware (per-language/-domain/custom
via the `config_pages_context` plugin type). Depends on core `text`.
Config UI: **Admin → Structure → Config pages** (`/admin/structure/config_pages`,
route `entity.config_pages.collection`).

- Create a type, add fields, edit the singleton, set up context → [configure/config_pages.md](configure/config_pages.md)
- Read a value in code (loader service / `config_pages_config()`) + context plugin API → [api/config_pages.md](api/config_pages.md)
- Render a field in Twig / expose it as a token → [theming/config_pages.md](theming/config_pages.md)
- Set/get field values from the CLI (Drush) → [drush/config_pages.md](drush/config_pages.md)
- Permissions (global + per-type) → [permissions/config_pages.md](permissions/config_pages.md)
