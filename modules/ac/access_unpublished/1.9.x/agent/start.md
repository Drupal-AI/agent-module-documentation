# access_unpublished — agent start

Generates time-limited **access tokens** so anyone with a special URL (default `?auHash=<value>`)
can preview a single unpublished entity — anonymous or authenticated, view-only. Tokens are an
`access_token` content entity; a request subscriber reads the token and `hook_entity_access()`
grants `view`. Depends on core `options`. Config UI:
**Admin → Config → Content → Access Unpublished** (`/admin/config/content/access_unpublished`);
settings route `access_unpublished.settings_form`. Token list: **Admin → Content → Access Tokens**
(`/admin/content/access_token`).

- Generate a token on a draft, the lifetime/hash-key settings, the token admin list → [configure/access_unpublished.md](configure/access_unpublished.md)
- Permissions (per-type view, renew/delete, overview) → [permissions/access_unpublished.md](permissions/access_unpublished.md)
- Token services, entity, access check, duration-options hook (in code) → [api/access_unpublished.md](api/access_unpublished.md)
