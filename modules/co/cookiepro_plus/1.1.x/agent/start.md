# CookiePro Plus — agent index

Injects the OneTrust CookiePro consent banner + Auto-Blocking + Google Consent Mode scripts into
front-end pages, driven by admin config with per-language overrides. Depends on core `path_alias`.
Config UI at `/admin/config/system/cookiepro-plus` (route `cookiepro_plus.configuration`,
permission `administer cookiepro_plus configuration`, restricted). Config schema, no Drush, no custom
plugin types.

- **All config keys, per-language overrides, pause mode, IP whitelist, path limiting, GCM, Auto-Blocking** →
  [configure/settings.md](configure/settings.md)
- **The `cookiepro_plus` service, the `CookieProGetDomainScript` event, and the embeddable blocks/tokens** →
  [api/service.md](api/service.md)

Key facts:
- Scripts are attached in `hook_page_attachments()` (`cookiepro_plus.module`) from a CDN
  (`cdn.cookiepro.com` / `cdn.cookielaw.org`), keyed by the `domain_script` (data-domain-script) value.
- Suppressed on admin routes, excluded paths, un-listed paths (when limiting on), paused configs, and
  whitelisted client IPs (which also trigger `page_cache_kill_switch`).
- Single permission `administer cookiepro_plus configuration` (restrict access: TRUE) gates all config.
- Ships a **default `ip_whitelist` of `20.54.106.120/29`** in `config/install` — review/clear it on install.
