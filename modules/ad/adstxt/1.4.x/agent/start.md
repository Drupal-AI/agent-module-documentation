# ads.txt — agent index

Serves IAB `ads.txt` and `app-ads.txt` from config at `/ads.txt` and `/app-ads.txt`, editable
in the admin UI. No dependencies. Provides one permission and a config schema; no Drush, no
plugins, no submodules.

- **Settings form, config keys, the two open routes, install seeding, requirements checks** →
  [configure/settings.md](configure/settings.md)
- **`hook_adstxt()` / `hook_app_adstxt()` to append lines programmatically** →
  [hooks/adstxt.md](hooks/adstxt.md)

Key facts:
- Config object `adstxt.settings` with `content` (ads.txt body) and `app_content` (app-ads.txt body).
- Config UI: `/admin/config/system/adstxt`, route `adstxt.admin_settings_form`, permission
  `administer ads.txt`.
- Output routes `/ads.txt` and `/app-ads.txt` are `_access: 'TRUE'` (public), `text/plain`,
  cacheable; empty content → cacheable 404.
- `hook_install()` seeds config from `DRUPAL_ROOT/ads.txt`, `sites/default/default.ads.txt`,
  or the module's sample file (first readable wins).
- `hook_requirements()`: ERROR if Clean URLs off; WARNING if a physical `ads.txt` exists in docroot.
