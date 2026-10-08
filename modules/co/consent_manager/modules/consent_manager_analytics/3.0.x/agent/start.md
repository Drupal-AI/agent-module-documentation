# consentmanager Analytics (consent_manager_analytics) — agent index

consent_manager submodule injecting the consentmanager.net "trackless" (cookieless) analytics
script into `page_bottom` on every non-admin page. Plugin `analytics` (`has_block: FALSE`). Depends
on `consent_manager`. Config `consent_manager_analytics.settings` at
`/admin/config/consent-manager/analytics` (permission `administer consent manager settings`,
restrict access). No permission/drush/plugin-type of its own.

- **Settings form, config keys, how to set it, self-injection & rendering** →
  [configure/settings.md](configure/settings.md)
- Plugin-type internals (shared base, `getCode()`) →
  [../../../../3.0.x/agent/plugins/plugin.md](../../../../3.0.x/agent/plugins/plugin.md)

Key facts:
- Plugin `src/Plugin/ConsentManager/Analytics.php`, `CODE = <script
  src="https://@host/trackless/delivery/@codeid.js" async></script>` (`@host` default
  `delivery.consentmanager.net`).
- Config keys: `codeid` (required), `host` (optional, hostname-validated). `getCode()` returns
  FALSE (injects nothing) without a Code-ID.
- Injected by `consent_manager_analytics_preprocess_html()` → `page_bottom`, cache tag
  `consent_manager_analytics`; skips admin routes.
- `hook_install` sets `consent_manager_cmp` weight = 100.
