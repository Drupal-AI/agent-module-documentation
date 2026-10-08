Hidden submodule of Analytics API that registers a Piwik/Matomo (`piwik`) analytics_service plugin so a site can add Piwik tracking through the Analytics UI.

---

`analytics_piwik` provides one `@AnalyticsService` plugin, `piwik` (`Piwik extends ServicePluginBase`), labelled "Piwik". Its configuration form has a required `url` (the Piwik base directory URL) and a required numeric `id` (Site ID), stored under the service entity's `service_configuration`. Its `getOutput()` currently returns a placeholder `<piwik src="…" site_id="…">` html_tag render element. A `validateUrl()` helper normalizes the URL and (when wired up) would validate it and probe `…/piwik.js` via `\Drupal::httpClient()` — note it is not attached as an `#element_validate` callback in this version, so validation is effectively dormant. The module is `hidden: true`, has no config schema file, and depends only on `analytics`. Configure it by enabling the submodule and adding a service of type "Piwik" at `/admin/config/services/analytics`; privacy/DNT/admin-suppression are inherited from the parent.

---

- Add Piwik/Matomo tracking to a site through the Analytics API UI.
- Store a Piwik base URL and Site ID as an analytics service config entity.
- Manage Piwik alongside Google and AMP analytics in one place.
- Inherit Do Not Track and admin-route suppression from the parent module.
- Enable/disable Piwik tracking without deleting its configuration.
- Export Piwik tracking configuration as deployable config.
- Exclude staff from Piwik tracking via `bypass all analytics services`.
- Point tracking at a self-hosted Matomo instance via the URL field.
- Provide Piwik as one option in a multi-service analytics setup.
- Configure Piwik via the standard analytics_service subform.
- Restrict who configures Piwik via `administer analytics`.
- Serve as a starting point for a full Matomo tracking implementation (current output is placeholder).
- Add Piwik tracking without editing page templates.
- Keep tracking config centralized with other services.
- Use the Analytics privacy toggles with Piwik.
