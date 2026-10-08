# Piwik PRO — agent index

Injects the Piwik PRO tag-manager container snippet into page output, gated by path/role/
content-type visibility rules. Configure via one settings form. Optional CSP-nonce support and
an analytics-dashboard submodule.

- **Settings form, all config keys, visibility rules, cookies, CSP nonce** →
  [configure/settings.md](configure/settings.md)
- **The snippet service + CSP event subscriber** → [api/snippet.md](api/snippet.md)
- **Permission** → [permissions/permissions.md](permissions/permissions.md)
- **Submodule (Piwik Pro Dashboard)** →
  [../../modules/piwik_pro_dashboard/1.4.x/agent/start.md](../../modules/piwik_pro_dashboard/1.4.x/agent/start.md)

Key facts:
- Config object `piwik_pro.settings`; form at `/admin/config/services/piwik-pro` (route
  `piwik_pro.admin_settings_form`, permission `administer piwik pro`, `restrict access: TRUE`).
- Snippet built by `piwik_pro.snippet` (`PiwikProSnippet::getSnippet()`) from `site_id`,
  `piwik_domain`, `data_layer`; emitted only if `isVisible()` (path AND role AND content-type
  checks all pass).
- `site_id` / `piwik_domain` are **public** client-side identifiers (not secrets).
- Optional CSP: `csp_nonce_enabled` + CSP module → nonce on the snippet; services use
  `@?csp.nonce_builder` / `@?csp.policy_helper` (optional). Requires `drupal/key` and
  `drupal/csp` per composer, but the base module depends only on `path_alias`.
- Submodule **piwik_pro_dashboard** (documented separately) — this is where API **credentials**
  live (via the Key module).
