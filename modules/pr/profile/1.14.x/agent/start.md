# profile — agent start

Fieldable user-profile entities: `profile` content entity + `profile_type` config bundle,
separate from the core user account, single or multiple per user. Depends on core
`field`/`user`/`views` and contrib `entity`. Config UI: **Admin → Config → People → Profile
types** (`/admin/config/people/profiles/types`, route `entity.profile_type.collection`).

- Create/configure profile types + attach fields (`profile.type.*`) → [configure/profile-types.md](configure/profile-types.md)
- Load/save profiles in code (storage + user syncer service) → [api/programmatic.md](api/programmatic.md)
- Permissions (admin + per-bundle from Entity API + role restriction) → [permissions/permissions.md](permissions/permissions.md)
- Theme profiles (template, view modes, preprocess) → [theming/theming.md](theming/theming.md)
