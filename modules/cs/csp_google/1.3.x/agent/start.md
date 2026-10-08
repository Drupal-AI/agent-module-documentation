<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CSP Google Supported Domains (csp_google) — agent index

A companion to the **CSP** module. It appends the country-code Google domains listed at
`https://www.google.com/supported_domains` to chosen CSP directives, so Google features that load
assets from localized Google hosts aren't blocked. Package: none declared. Depends on
`drupal/csp` (`^1.31 || ^2.0`); Drupal module dependency **`csp`**. Core requirement
`^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.3.0.

- **How it hooks into CSP, the settings checkbox, the event subscriber, the domain fetch/cache,
  and how to operate it** → [config/settings.md](config/settings.md)

## What it actually is

- **No routes, no permissions, no plugins, no Drush, no submodules.** It has no settings page of
  its own — it extends the CSP module's form and policy building.
- Two services (`csp_google.services.yml`):
  - `csp_google.csp_policy_subscriber` → `Drupal\csp_google\EventSubscriber\CspPolicy`
    (args: `@config.factory`, `@csp_google.helper`), tagged `event_subscriber`.
  - `csp_google.helper` → `Drupal\csp_google\GoogleSupportedDomainsHelper`
    (args: `@state`, `@http_client`).
- `.module` hooks: `hook_config_schema_info_alter()` adds boolean
  `csp_google_add_google_domain_sources` to the `csp_policy` schema mapping;
  `hook_form_csp_settings_alter()` + submit handler add/save an **"Add Google supported domains"**
  checkbox per directive.
- `.install`: `hook_install()` primes the domain cache; `hook_uninstall()` deletes it.

## Mechanism (from source)

- **Fetch/cache** — `GoogleSupportedDomainsHelper` (`src/GoogleSupportedDomainsHelper.php`):
  `URL = https://www.google.com/supported_domains`, state key
  `STATE_KEY = csp_google_supported_domains`. `updateSupportedDomains()` GETs the URL via the
  core `http_client` (Guzzle, TLS verified), splits the body on newlines, trims each line
  (whitespace + leading dots), and stores the array in **state**; throws `\RuntimeException` on
  non-200/empty. `getSupportedDomains()` returns the cached array, lazily calling
  `updateSupportedDomains()` if state is unset. Not refreshed on cron — only at install or when
  state is empty.
- **Policy alter** — `CspPolicy::onCspPolicyAlter()` subscribes to `CspEvents::POLICY_ALTER`.
  Picks the `report-only` or `enforce` config branch from `csp.settings` by
  `$policy->isReportOnly()`. For each directive present on the policy whose stored value is an
  array with a truthy `csp_google_add_google_domain_sources`, it appends `*.<domain>` and
  `<domain>` for every cached domain (skipping duplicates) and writes the directive back with
  `$policy->setDirective()`.
- **Form** — `csp_google_form_csp_settings_alter()` walks `report-only` and `enforce` directive
  children that expose `options.sources`, adds the checkbox (default from stored config), and
  registers `csp_google_form_csp_settings_form_submit()`, which persists each per-directive flag
  into `csp.settings` (skipping policies where `enable === FALSE`).

## Notes

- Enabling the option on many directives can make the `Content-Security-Policy` header large
  enough to hit reverse-proxy / CDN header-size limits (README warns of 502s). Enable it only on
  the directives that need it.
- Only needed for Google features using ccTLD hosts (some ad features); basic Analytics does not
  require it.
