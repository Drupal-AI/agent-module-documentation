# Visually Impaired Support (module) — agent index

A low-vision "accessibility version" switcher. Two blocks render buttons that set a
`visually_impaired` cookie (`on`/`off`); a theme negotiator serves a chosen theme while the
cookie is `on` and the route is non-admin. Depends on core `page_cache`. No permissions of its
own (settings use `administer site configuration`), no Drush, no config schema.

- **Settings form, config key, the two blocks, theme negotiator, and the page-cache override** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Configure route `visually_impaired_module.settings` → `/admin/config/user-interface/visually_impaired_module`.
- Config object `visually_impaired_module.visually_impaired_module.settings`, single key
  `visually_impaired_theme` (a theme machine name).
- Blocks: `visually_impaired_block` (turn ON, `VISpecialForm`), `normal_block` (turn OFF, `VINormalForm`);
  each has a "Block style" radio (0=Text, 1=Image).
- Cookie: `setcookie('visually_impaired', 'on'|'off', 0, '/')` — session cookie, no expiry.
- Replaces `http_middleware.page_cache` with `StackMiddleware\MyCache` so page-cache IDs vary by the cookie.
