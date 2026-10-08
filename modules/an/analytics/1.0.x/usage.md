Analytics API provides a common plugin-based framework and admin UI for adding third-party analytics/tracking services (Google Tag Manager, Google Optimize, Google Analytics, Piwik/Matomo, AMP) to a Drupal site, with shared privacy controls (Do Not Track, IP anonymization).

---

The module defines an `analytics_service` plugin type (`AnalyticsServiceManager`, annotation `@AnalyticsService`, base `ServicePluginBase`) and an `analytics_service` config entity: each configured service is a config entity that selects one plugin and stores its configuration, managed at `/admin/config/services/analytics` (route `entity.analytics_service.collection`, the `configure` target). Plugins implement `getOutput()` returning a render array; `analytics_page_bottom()` iterates enabled services and, for each whose `canTrack()` passes, appends its output to the page. `canTrack()` suppresses tracking on admin routes and for users with the `bypass all analytics services` permission, and fires an `analytics_service_can_track_access` alter hook. Two shared privacy settings live in `analytics.settings` (config form at `/admin/config/services/analytics/settings`): `privacy.dnt` (when on, wraps each snippet in a `navigator.doNotTrack` guard via `AnalyticsJsMarkup` and attaches a DNT JS library) and `privacy.anonymize_ip`; plus `cache_urls` and `disable_page_build` (short-circuits all output). Core ships plugins for Google Tag Manager (container id + JSON data layer + optional Optimize anti-flicker), Google Optimize, and provides base wiring; the bundled hidden submodules add Google Analytics (`analytics_google`), AMP analytics/tracking-pixel (`analytics_amp`, requires the `amp` module), and Piwik (`analytics_piwik`). Enable/disable of a service is done via CSRF-protected AJAX operations (`AnalyticsController::ajaxOperation`). Config schema is provided for the settings and per-plugin service configuration. All configuration is behind the `administer analytics` permission; the tracking snippets services emit are, by design, admin-authored JavaScript injected site-wide.

---

- Add Google Tag Manager to a site with a container ID and JSON data layer.
- Add Google Analytics tracking through the analytics_google submodule.
- Integrate Piwik/Matomo analytics via the analytics_piwik submodule.
- Add Google Optimize experiments with optional anti-flicker snippet.
- Serve AMP analytics or an AMP tracking pixel on AMP routes (analytics_amp).
- Manage multiple analytics services from one admin listing.
- Configure several instances of the same service (e.g. two GTM containers) where the plugin allows `multiple`.
- Enable or disable a tracking service without deleting its configuration.
- Respect Do Not Track by wrapping snippets in a navigator.doNotTrack guard.
- Anonymize visitor IP addresses via the shared privacy setting.
- Let privileged users bypass all analytics with the `bypass all analytics services` permission.
- Automatically suppress analytics on admin routes.
- Disable all analytics output globally with a single `disable_page_build` toggle.
- Add a JSON data layer to Google Tag Manager for enhanced ecommerce/events.
- Provide a common API so custom modules can add their own analytics service plugin.
- Alter a service's tracking access with `hook_analytics_service_can_track_access_alter`.
- Alter the plugin definition list with `hook_analytics_service_info_alter`.
- Inject per-service data-layer values via the `analytics_<id>_data` alter hook.
- Centralize tracking configuration in config entities that can be exported/deployed.
- Keep tracking snippets out of the render cache selectively via cache metadata.
- Add an Optimize anti-flicker CSS/JS snippet to reduce page flicker during experiments.
- Standardize how a site loads Adobe/Google AMP analytics on AMP-enabled pages.
