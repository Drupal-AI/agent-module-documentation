# flag — agent start

Toggleable "flags" (bookmark/favorite/follow/report) on entities. Flags are config
entities managed at **Admin → Structure → Flags** (`/admin/structure/flags`, route
`entity.flag.collection`). Each set is a `flagging` entity. Core service: `flag`.

- Create/configure flags (fields, link text, global vs per-user) → [configure/flags.md](configure/flags.md)
- Plugin types it defines (FlagType, ActionLink) → [plugins/plugins.md](plugins/plugins.md)
- Flag/unflag & lookups in code (services) → [api/services.md](api/services.md)
- Alter hooks & flag/unflag events → [hooks/hooks.md](hooks/hooks.md)
- Permissions (admin + per-flag use) → [permissions/permissions.md](permissions/permissions.md)
- Template & Twig count function → [theming/theming.md](theming/theming.md)
