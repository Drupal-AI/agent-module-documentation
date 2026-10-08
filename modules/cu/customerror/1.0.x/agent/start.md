# Custom Error — agent index

Custom 403/404 error pages (title + HTML body + optional theme + optional login form) plus regex
404 redirects, driven by config. Depends on `path_alias`. No permissions of its own (settings form
uses core `access site administration`), no plugins, no Drush.

- **Config keys, the required core wiring, redirects, login form, templates, and known quirks** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Route `customerror.error_page` = `/customerror/{code}` (`code` default 404, `_access: 'TRUE'` — public).
- Settings form route `customerror.settings` = `/admin/config/system/customerror`
  (`_permission: 'access site administration'`); this is the `configure` route.
- Config object `customerror.settings`: `403.{title,body,theme}`, `404.{title,body,theme}`, `redirect`
  (schema provided; note `enable_login` is used in code but not in the schema).
- Requires core *Basic site settings* → error pages set to `/customerror/403` and `/customerror/404`.
- Theme hook `customerror` (`customerror.html.twig`), suggestions `customerror__{code}`.
