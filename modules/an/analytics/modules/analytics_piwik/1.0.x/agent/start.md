# Piwik Analytics (analytics_piwik) — agent index

Hidden submodule of [Analytics API](../../../../1.0.x/agent/start.md). Adds one `analytics_service`
plugin. Depends on `analytics`. No settings route of its own — configured as a service at
`/admin/config/services/analytics`.

Key facts:
- Plugin `piwik` (`Piwik extends ServicePluginBase`), "Piwik". Config: required `url` (Piwik base
  dir) + required numeric `id` (Site ID).
- No config schema file in this submodule.
- `getOutput()` returns a placeholder `<piwik src site_id>` html_tag. `validateUrl()` exists but
  is NOT attached as an `#element_validate` callback in this version (dormant; would probe
  `…/piwik.js` via the HTTP client).
- Plugin framework: [../../../1.0.x/agent/plugins/analytics-service.md](../../../../1.0.x/agent/plugins/analytics-service.md).
