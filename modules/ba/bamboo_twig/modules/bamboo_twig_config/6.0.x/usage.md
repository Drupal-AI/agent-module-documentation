<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bamboo Twig - Config adds Twig functions to read Drupal Config API objects, `settings.php` values, and State API values directly from a template.

---

This submodule of Bamboo Twig registers three getter functions on the service `bamboo_twig_config.twig.config`: `bamboo_config_get(name, key)` returns a value from a Config API object (`\Drupal::config(name)->get(key)`), `bamboo_settings_get(key)` returns a `settings.php` value via the read-only Settings singleton, and `bamboo_state_get(key)` returns a State API value. Each returns `null` when the requested value is absent. Together they let themers surface configuration and runtime values in markup without a preprocess hook, keeping presentation logic in the template where it belongs.

---

- Print the site name (`bamboo_config_get('system.site', 'name')`) in a header template.
- Show the site slogan from configuration.
- Read the default front-page path from `system.site`.
- Display the configured admin email or contact address from config.
- Surface a module's setting (e.g. `mymodule.settings`) in a template.
- Show which user-registration mode is configured (`user.settings:register`).
- Read a feature flag stored in a custom config object.
- Read a `settings.php` value such as an environment indicator via `bamboo_settings_get`.
- Expose a deployment identifier stored in settings to the front end.
- Read the last cron run time from State (`bamboo_state_get('system.cron_last')`).
- Surface a maintenance or banner flag stored in the State API.
- Display a counter or timestamp kept in State.
- Conditionally show markup based on a config value in an `{% if %}`.
- Avoid a preprocess function just to pass one config value to a template.
- Keep environment-specific values (from settings.php) out of exported config but visible in Twig.
- Read theme-related settings from configuration for conditional rendering.
- Show a configured phone number or social handle from a settings object.
- Drive template behaviour from State without touching PHP.
- Combine config, settings and state reads in one template.
