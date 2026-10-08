# metatag — agent start

Manages HTML `<meta>`/`<link>` tags for all entities and pages. Defaults are
`metatag_defaults` config entities; per-entity overrides via a Metatag field. Depends on
`token` + core `field`. Config UI: **Admin → Config → Search and metadata → Metatag**
(`/admin/config/search/metatag`, route `entity.metatag_defaults.collection`).

- Manage default tags, per-bundle defaults, global settings → [configure/settings.md](configure/settings.md)
- Define a new meta tag or tag group (plugins) → [plugins/tags-and-groups.md](plugins/tags-and-groups.md)
- Generate/read tags in code (manager service) → [api/manager.md](api/manager.md)
- Alter tags for any route/page via hooks → [hooks/hooks.md](hooks/hooks.md)
- Permission (`administer meta tags`) → [permissions/permissions.md](permissions/permissions.md)
- Submodules add tag families (Open Graph, Twitter Cards, Dublin Core, mobile, favicons, verification, …) — see each submodule's own docs.
