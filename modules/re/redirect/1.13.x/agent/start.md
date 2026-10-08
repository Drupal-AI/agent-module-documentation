# redirect — agent start

Serves 301/302 URL redirects via a `redirect` entity + a request subscriber; can auto-create
redirects when aliases change. Depends on core `path_alias`, `link`, `views`. Config UI:
**Admin → Config → Search and metadata → URL redirects** (`/admin/config/search/redirect`);
settings route `redirect.settings`.

- Manage redirects + global settings → [configure/settings.md](configure/settings.md)
- Create/look up redirects in code (services + entity) → [api/api.md](api/api.md)
- Alter the redirect response via hook → [hooks/hooks.md](hooks/hooks.md)
- Permissions → [permissions/permissions.md](permissions/permissions.md)
