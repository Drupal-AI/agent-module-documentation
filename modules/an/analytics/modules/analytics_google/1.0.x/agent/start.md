# Google Analytics (analytics_google) — agent index

Hidden submodule of [Analytics API](../../../../1.0.x/agent/start.md). Registers one
`analytics_service` plugin, `google_ga` ("Google Analytics (ga.js)"), so a site can add
Google Analytics tracking as an analytics service. Depends only on `analytics`; empty
`.module` file. No settings route of its own — configure it as a service at
`/admin/config/services/analytics` (parent's `entity.analytics_service.collection`).

- **Add/configure a Google Analytics service, its Tracking ID config + schema, how the
  tag is emitted at page bottom, drush/PHP config** →
  [configure/google-analytics.md](configure/google-analytics.md)
- **The `analytics_service` plugin type this plugin implements (getOutput/canTrack, alter
  hooks, privacy/DNT)** →
  [../../../../1.0.x/agent/plugins/analytics-service.md](../../../../1.0.x/agent/plugins/analytics-service.md)

Key facts:
- Plugin id `google_ga`, class `Drupal\analytics_google\Plugin\AnalyticsService\GoogleAnalyticsGa`
  (`extends ServicePluginBase`, annotation `@AnalyticsService`, `multiple = true`).
- Single config key `id` (Tracking ID), a required `number` form element (`#min` 0);
  default `NULL`.
- Config schema `analytics.service_configuration.google_ga` → `id` (string), stored on the
  parent `analytics_service` config entity.
- `getOutput()` returns a placeholder `<googleanalytics tracking_id="…">` `html_tag`
  render element (marked "just placeholder code"); rendered via parent
  `analytics_page_bottom()` when `canTrack()` passes.
- No permissions, drush commands, routes, or plugin types of its own. Privacy (DNT,
  admin-route/bypass suppression) is inherited from the parent.
