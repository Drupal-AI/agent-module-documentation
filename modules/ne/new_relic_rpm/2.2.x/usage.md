<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
New Relic RPM connects a Drupal site to the New Relic APM service: it names/ignores/backgrounds transactions, forwards errors and slow-view events, marks deployments, and can forward watchdog log messages, all driven by the `new_relic_rpm.settings` config object.

---

The module talks to New Relic through two channels. The **PHP extension** (the `newrelic` C extension, exposing `newrelic_*()` functions) is wrapped by an adapter chosen at runtime by `AdapterFactory`: `ExtensionAdapter` when the extension is loaded, otherwise a no-op `NullAdapter`, so the site never fatals when the agent is absent. Event subscribers use that adapter to name each web transaction after its route, to mark configured URLs/roles as ignored or background, to optionally forward exceptions, and to disable AutoRUM. The **REST API v2** is used by `NewRelicApiClient` (Guzzle) with an `api_key` to create deployment markers against the application named by the `newrelic.appname` PHP ini value. All behavior is configured at `/admin/config/development/new-relic` (route `new_relic_rpm.settings`) and stored in `new_relic_rpm.settings`; a second tab at `/admin/config/development/new-relic/deploy` creates deployments from the UI. A Drush command `new-relic-rpm:deploy` (alias `nrd`) marks deployments from CLI, and a Drush `pre-command` hook applies the `track_drush` transaction state to every Drush call. `hook_cron`, `hook_modules_installed/uninstalled` and `hook_views_pre_build/post_render` add cron transaction control, module-change deployment markers, and slow-view Insights events. Two permissions gate the settings form and deployment creation.

---

- Automatically name New Relic web transactions after the Drupal route instead of `index.php`.
- Mark administrative or cron URLs as "ignored" so they do not pollute APM throughput stats.
- Track selected URLs as background jobs rather than web transactions.
- Exclusively track a small set of URLs while ignoring everything else, to debug one path.
- Ignore all requests made by users holding a given role (e.g. an uptime-monitor account).
- Forward uncaught PHP exceptions to New Relic by overriding Drupal's exception handler.
- Forward watchdog log messages at chosen severities (error, critical, …) to New Relic as errors.
- Create a New Relic deployment marker from the CLI on every release with `drush nrd 1.2.3`.
- Add a deployment description, deploying user and changelog to the deployment marker.
- Create a deployment marker automatically whenever a module is installed or uninstalled.
- Create a deployment marker automatically whenever configuration is imported.
- Record slow Views renders as custom Insights events (`SlowView`) above a millisecond threshold.
- Choose how Drush commands are tracked (ignore / background / normal) via `track_drush`.
- Choose how cron runs are tracked (ignore / background / normal) via `track_cron`.
- Disable New Relic's automatic Real User Monitoring (AutoRUM) JS injection site-wide.
- Store the New Relic REST API key in config to enable in-Drupal deployment calls.
- Keep the site running unchanged when the `newrelic` PHP extension is not installed (NullAdapter).
- Add custom parameters/attributes to the current transaction from custom code via the adapter service.
- Set a custom transaction name from your own code through `new_relic_rpm.adapter`.
- Gate access to the New Relic settings form with the "administer new relic rpm" permission.
- Gate deployment creation with the "create new relic rpm deployments" permission.
- Programmatically create deployment markers from custom code via the `new_relic_rpm.client` service.
- Configure everything as exportable config (`new_relic_rpm.settings`) for deployment across environments.
- Reduce noise from a health-check endpoint by adding it to the "Ignore URLs" list.
