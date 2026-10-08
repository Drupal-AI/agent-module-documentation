<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Config Export JSON exposes **selected Drupal configuration as JSON**. An admin lists the config objects/keys to
expose, and the module serves them from a REST resource (`/api/config.json`) and also writes them to a public
file (`sites/default/files/config/config.json`).

Use it to make chosen configuration available to a decoupled front end or external system as JSON. Only the
configs explicitly listed in the settings form are included — it is not a full-site config dump by default.
---
- Requires `config` and `rest`; enable with `ddev drush en config_export_json`.
- Admin form at `/admin/config/services/config-export-json` (permission `administer site configuration`).
- Enter configs to expose, one per line, as `config.name` (whole object) or `config.name:key` (single key).
- Saving regenerates the public JSON file under the public files directory.
- The REST resource `/api/config.json` must be enabled/configured via the REST/Views UI or config.
- Store nothing secret in exposed configs — see the security note below.
---
- Expose specific configuration objects as JSON.
- Expose a single key of a config object.
- Serve config to a decoupled/headless front end.
- Regenerate a static `config.json` public file on save.
- Provide config via a REST GET at `/api/config.json`.
- Curate exactly which configs are shared (allow-list).
- Add cacheability metadata to the REST response.
- Integrate config into external tooling as JSON.
- Keep the exposed list deployable as configuration.
- Merge programmatically-added configs via the service API.
- Support D8–D10 sites.
- Avoid exporting the whole site config (opt-in only).
- SECURITY: the REST endpoint only checks `access content` (anon-effective) — treat every exposed value as PUBLIC.
- SECURITY: the generated `config.json` sits in the public files dir and is web-readable with NO permission check.
- Never list a config containing secrets/keys/tokens in the exposed list.
- Review the exposed list before every deploy.
