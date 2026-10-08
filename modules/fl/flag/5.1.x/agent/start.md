# flag — agent start

Toggleable "flags" (bookmark/favorite/follow/report) on entities. Flags are config
entities managed at **Admin → Structure → Flags** (`/admin/structure/flags`, route
`entity.flag.collection`). Each mark is a `flagging` entity (a bundle of the flag). Core
service: `flag`. Version 5.1.x (`^10.3 || ^11 || ^12`, Drupal 12-ready).

- Create/configure flags (fields, link text, global vs per-user) → [configure/flags.md](configure/flags.md)
- Plugin types it defines (FlagType, ActionLink) → [plugins/plugins.md](plugins/plugins.md)
- Flag/unflag & lookups in code (services) → [api/services.md](api/services.md)
- Alter hooks & flag/unflag events → [hooks/hooks.md](hooks/hooks.md)
- Permissions (admin + per-flag use) → [permissions/permissions.md](permissions/permissions.md)
- Template & Twig `flagcount()` / `flaglink()` functions → [theming/theming.md](theming/theming.md)
