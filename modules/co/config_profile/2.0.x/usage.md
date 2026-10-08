<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Config Export Profile mirrors your site's active configuration into an install profile's `config/install` directories every time you run `drush config-export`, so a distribution or reusable profile's shipped config stays in sync with the site it is built from.

---

Distribution and install-profile maintainers work on a live development site, then have to copy the resulting configuration back into the profile's `config/install` (and nested module) directories by hand — tedious and error-prone. Config Export Profile automates this: it subscribes to Drupal's config storage-transform export event, so whenever configuration is exported (`drush cex`) it also writes each changed config object into the configured profile, overriding the file in whatever directory it already lives (recursively, including modules nested inside the profile) or creating a new file in the profile's `config/install`. It strips `uuid` and `_core` keys so the exported config is portable and can be installed anywhere, and it lets you blacklist whole config names (with wildcards) and individual config properties that should never be pushed into the profile. Configuration lives in one config object (`config_profile.settings`) edited at a settings form under Configuration → Development → Synchronize → Profile, gated by the core `export configuration` permission. It runs as a side effect of the normal export, so your site's real config-sync directory is still written too. It is purely a maintainer/build-time tool with no runtime request surface.

---

- Keep a Drupal distribution's shipped config in sync with the development site it is built on.
- Auto-export active configuration into an install profile's `config/install` on every `drush config-export`.
- Update config that lives in modules nested inside a profile (`profiles/x/modules/y/config/install`), in place.
- Build a reusable install profile without hand-copying config YAML.
- Strip `uuid` and `_core` from exported profile config so it is portable across environments.
- Override existing profile config files where they already sit instead of dumping everything into one directory.
- Add newly-created config objects to the profile's `config/install` automatically.
- Exclude sensitive or environment-specific config names from the profile via a wildcard blacklist (e.g. `webform.webform.*`, `block.block.*`).
- Blank out individual config property values on export (e.g. `system.site.mail`) via the property blacklist.
- Remove a value from a sequence in exported config using the property blacklist.
- Reduce configuration drift between a profile and the site maintaining it.
- Point exports at a specific profile by machine name from a simple settings form.
- Keep your normal site config-sync export working unchanged while also feeding the profile.
- Clean out stale config files from the profile's `config/install` before re-exporting a fresh set.
- Support a team building a Drupal product/distribution with repeatable config exports.
- Avoid manual mistakes when maintaining large profiles with many bundled modules.
- Restrict who can change the target profile and blacklists to holders of the `export configuration` permission.
- Enable only on the build/development environment, not on production instances of the distribution.
- Pair with core Configuration Manager for the standard config-sync workflow.
- Empty the main config-sync directory first when you want a complete re-export to the profile.
- Review the exported file locations before committing so config lands in the correct profile directory.
