Hidden submodule of the Analytics API that registers a Google Analytics (`google_ga`) `analytics_service` provider plugin, letting a site add Google Analytics tracking through the central Analytics UI at `/admin/config/services/analytics`.

---

`analytics_google` ships exactly one `@AnalyticsService` plugin, `google_ga` (`GoogleAnalyticsGa extends ServicePluginBase`, `multiple = true`), labelled "Google Analytics (ga.js)". Its configuration form exposes a single required numeric `id` (Tracking ID), stored under the parent `analytics_service` config entity's `service_configuration` (schema `analytics.service_configuration.google_ga` → `id`). Its `getOutput()` currently returns a placeholder `<googleanalytics tracking_id="…">` `html_tag` render element (the code comments mark it as placeholder, not a real gtag snippet). The module is `hidden: true`, has an empty `.module` file, defines no routes/permissions/drush/plugin-types, and depends only on `analytics`. You use it by enabling the submodule and adding a "Google Analytics" service; the tag is emitted by the parent's `analytics_page_bottom()` when the plugin's inherited `canTrack()` passes. All privacy handling (DNT, admin-route suppression, the `bypass all analytics services` permission) comes from the parent Analytics API.

---

- Add Google Analytics tracking to a site through the central Analytics API UI.
- Store a Google Analytics Tracking ID as an `analytics_service` config entity.
- Run multiple Google Analytics instances on one site (plugin allows `multiple`).
- Inherit Do Not Track and admin-route suppression from the parent module.
- Enable or disable a Google Analytics service without deleting its configuration.
- Export Google Analytics tracking configuration as deployable Drupal config.
- Offer GA as one of several analytics services managed in a single place.
- Exclude staff from GA tracking via the `bypass all analytics services` permission.
- Configure GA through the standard `analytics_service` subform (no custom route).
- Keep GA config schema-validated (`analytics.service_configuration.google_ga`).
- Combine GA with Google Tag Manager, Optimize, Piwik/Matomo, or AMP on one site.
- Create a GA service programmatically with `AnalyticsService::create([...])`.
- Set a Tracking ID from config via `drush config:set analytics.analytics_service.<id>`.
- Serve as a starting point / stub for a full GA4/gtag implementation.
- Restrict who can configure GA using the parent `administer analytics` permission.
- Toggle all analytics output site-wide with the parent `disable_page_build` setting.
- Add GA without hand-editing page templates or theme code.
- Keep GA configuration under version control alongside other site config.
- Manage GA next to central privacy toggles (DNT, anonymize IP) in one UI.
- Load Google Analytics only on non-admin front-end pages via inherited `canTrack()`.
