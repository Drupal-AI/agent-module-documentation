<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Telemetry (internal)

New in the 2.2.x line. All telemetry classes are `@internal` — do not call them from other
code; they may change or be removed without warning. Described here only so agents know the
module sends anonymous usage data and how an operator controls it.

## What it does

`TelemetryManager` queues usage events (Drupal queue `drupal_cms_telemetry`) and, on cron,
POSTs them in batches (default 500) to Amplitude's EU endpoint
`https://api.eu.amplitude.com/2/httpapi` over HTTPS. The Amplitude API key is embedded and is
public per Amplitude's documentation. Each event carries a `device_id` =
`Crypt::hmacBase64(system.site uuid, hash salt)` — unique per site, not personally
identifiable — and an `is_production` flag.

Events (`Telemetry` enum): `site_template_install`, `module_install`, `module_uninstall`,
`recipe_apply`, `admin_page` (visits to a short allow-list of admin routes: automatic-updates,
checklist SEO/language, webform collection, and Project Browser "recommended" add-ons),
`code_component` (a Canvas JS component was created), `user_login` (carries only
`Crypt::hmacBase64(uid, site private key)` — no PII), and `ping` (a monthly liveness signal).

## Opt-in / control

- Default state is unset. Nothing is sent until an admin explicitly opts in.
- A non-modal opt-in dialog (`TelemetryOptInForm`, library `drupal_cms_helper/telemetry`) is
  rendered in `hook_page_bottom` only when: status is unset, the current user has
  `administer site configuration`, and the route is an admin route. The checkbox also appears
  on the Basic site settings form (`system_site_information_settings`).
- The setting is stored in state key `drupal_cms_telemetry`. Setting it to `FALSE` deletes the
  queue. Read/set via `TelemetryManager::status()`.
- Cron skips sending entirely under test, preview, or CI environments
  (`drupal_valid_test_ua()` / `DrupalEnvironment\Environment`).

Documentation of what is collected: `https://project.pages.drupalcode.org/drupal_cms/updates/telemetry`.
