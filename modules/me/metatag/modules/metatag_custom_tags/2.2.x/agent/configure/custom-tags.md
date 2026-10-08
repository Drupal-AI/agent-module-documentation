# Custom meta tags (no code)

Adds a `metatag_custom_tag` **config entity** and admin UI to define your own tags without
writing a `MetatagTag` plugin.

- Manage at `/admin/config/search/metatag/custom_tags` (route
  `entity.metatag_custom_tag.collection`; `metatag_custom_tags.routing.yml`).
- Per custom tag choose: machine id, label, **type** (meta name / meta property /
  link rel), group/tab, and default value (token-enabled).
- Once defined, the tag appears in **every** Metatag defaults form and the per-entity
  Metatag field, just like built-in tags.
- Definitions are exportable config; deploy them between environments.

**Permission:** `administer custom meta tags` (`restrict access: TRUE`) — manage settings
and modify custom tags. Schema:
`config/schema/metatag_custom_tags.metatag_custom_tag.schema.yml`,
`…metatag_custom_tags.metatag_tag.schema.yml`.
