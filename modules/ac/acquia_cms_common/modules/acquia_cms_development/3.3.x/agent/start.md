<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# acquia_cms_development — agent index

Submodule of **acquia_cms_common**. A developer/testing helper that pre-wires Acquia integrations and
loosens performance settings on internal Acquia dev/IDE/local environments. "This is for development and
testing purposes only; this code is not shipped with Acquia CMS." Not for production sites.

Resolved release: **3.3.13** (packaged inside the acquia_cms_common tarball). Core `^10.2.2 || ^11`.
Depends on: `acquia_connector`, `acquia_search`, `config_rewrite`.

No routes, no permissions, no drush commands, no config schema, no settings page. It acts entirely through
one config override service plus an install hook.

- **What it overrides / configures on install** → [hooks/dev-config.md](hooks/dev-config.md)

## Key facts
- Config override service `acquia_cms_development.config_overrider` (`Config\ConfigOverrider`, tagged `config.factory.override` priority 5).
- Overrides `acquia_search.settings:override_search_core` to `<CONNECTOR_ID>.dev.orionacms` on Acquia IDE envs.
- Overrides `system.performance` (page `max_age` 0, css/js preprocess off) on IDE + local envs.
- `hook_install` reads env vars `CONNECTOR_KEY`, `CONNECTOR_ID`, `SEARCH_UUID`, `SHIELD_USER`, `SHIELD_PASS`, `GMAPS_KEY` to pre-configure Acquia Connector, Acquia Search, Shield (Acquia non-IDE only), and the Google Maps API key.
