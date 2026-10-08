<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Config Override gives developers structured ways to override configuration per environment — from a site file, from a module, or from environment variables — instead of stacking `$config[...]` lines in `settings.php`.

---

Drupal's configuration override system is a good mechanism with a poor front end: overriding a value means writing `$config['system.site']['name'] = ...` into `settings.php`, and a real project accumulates dozens of such lines across several environment-specific includes, with no structure, no discoverability and no way for a module to ship its own. This module supplies the missing organisation through three override sources — `SiteConfigOverrides` for site-level overrides, `ModuleConfigOverrides` so a module can contribute its own, and `EnvironmentConfigOverride` backed by `symfony/dotenv`, which is the interesting one because it lets configuration be driven by environment variables in the way containerised deployments expect. `ConfigOverrideServiceProvider` registers them. There are no routes, permissions or UI — it is developer infrastructure, and the core requirement is `^10 || ^11`. Two things follow from how Drupal's override system works and are worth stating: overrides are **runtime-only**, so an overridden value is what the site uses but is not what `drush cex` writes — which is exactly the desired behaviour for environment differences and a common source of confusion; and overridden values do not appear in the admin forms as editable, which is correct but surprises site builders.

---

- Override configuration per environment.
- Drive settings from environment variables.
- Keep environment differences out of config exports.
- Let a module ship its own overrides.
- Replace a pile of $config lines in settings.php.
- Configure a container deployment from env vars.
- Override an API endpoint on staging.
- Keep production credentials out of git.
- Structure overrides across many sites.
- Override a mail transport in development.
- Use a .env file for site configuration.
- Disable a feature on one environment.
- Provide sensible defaults from a module.
- Keep config exports environment-neutral.
- Override site name per environment.
- Support a twelve-factor deployment.
- Reduce settings.php sprawl.
- Make overrides discoverable to developers.
