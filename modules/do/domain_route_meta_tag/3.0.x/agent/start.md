# Domain Route Meta Tag — agent index

Per-route, per-domain meta tags for Domain Access multi-sites. Adds a
`domain_route_meta_tag` content entity + admin UI; emits `<meta>` and
`<link rel="canonical">` into the page head when the active domain and current
path match a record.

- Requires the `domain` module (Domain Access); at least one Domain entity must exist.
- Not a config entity — a fieldable **content entity** in table `domain_route_meta_tag`.
- No Drush commands, no plugin types, no config schema, no bundled libraries.

## Docs
- [configure/meta-tag-records.md](configure/meta-tag-records.md) — the entity, its
  fields, admin routes, how matching + output + caching work, save-time validation.
- [permissions/permissions.md](permissions/permissions.md) — the `access domain meta`
  permission and an access caveat on the list route.
