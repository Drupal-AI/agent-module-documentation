<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Digital Analytics Program (usfedgov_google_analytics) — agent index

Attaches the **US GSA Digital Analytics Program (DAP)** "Universal Federated Analytics"
tracking script to public pages. Version **3.0.0**, core `^10.3 || ^11`, package Statistics.
No dependencies. All behaviour is configuration-driven from one config object.

## What it does (mechanism)
- `hook_page_attachments` (`src/Hook/PageAttachments.php`) attaches an asset library from
  `usfedgov_google_analytics.libraries.yml`. **Attaches only when** `status` is on, an
  **Agency is set**, the user is **anonymous**, the route is not `user.login`/`user.logout`/
  `user.pass`, and it is **not an admin route**. Adds cache tag
  `config:usfedgov_google_analytics.settings`.
- `hook_js_alter` (`src/Hook/JsUrlQueryBuilder.php`) appends the configured DAP options to the
  `Universal-Federated-Analytics(-Min).js` URL as a query string (`UrlHelper::buildQuery`,
  URL-encoded; booleans rewritten to literal `true`/`false`; only non-default, non-empty
  values sent).
- Script source: **DAP CDN** `https://dap.digitalgov.gov/Universal-Federated-Analytics-Min.js`
  (`id="_fed_an_ua_tag"`, `async`) by default, or bundled local copies (8.0.0 / 8.5.0 / 8.6.0,
  minified or not) under `js/`.
- `hook_runtime_requirements` (`src/Hook/RuntimeRequirements.php`) shows a status-report
  warning while the Agency is blank.

## Key facts
- **Config object:** `usfedgov_google_analytics.settings` (schema `config/schema/`, defaults
  `config/install/`). Fields: `status`, `library`, and `query_parameters.*`.
- **Settings route:** `/admin/config/services/dap` (`usfedgov_google_analytics.form`).
- **Permission:** `administer federal google analytics` (gates the route).
- **Required field:** `query_parameters.agency` — nothing loads without it.
- On save, the form clears the library-discovery cache (query string is baked into the
  library definition at build time).

## Solution docs
- [config/settings.md](config/settings.md) — every setting, defaults, the attach conditions,
  and how to configure it via `drush`.

Legacy procedural wrappers in `.module`/`.install` (`#[LegacyHook]`) just delegate to the
`src/Hook/` classes; the OOP hook classes are the real implementation.
