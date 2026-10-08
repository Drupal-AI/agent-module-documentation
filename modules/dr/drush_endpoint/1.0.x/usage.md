<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
An HTTP endpoint (`POST /api/drush/{command}`) that runs a small allowlist of Drush commands during automated testing.

---

Drush Endpoint lets an automated test suite trigger a handful of Drush maintenance commands over HTTP, for setups where the test runner cannot call Drush directly (for example a Cypress suite running in a container separate from the web server). Commands are reached at `POST /api/drush/{command}`, and only a fixed allowlist is permitted: `cr`, `cron`, `uli`, `mim`, `mr`, `sapi-i`, `sapi-r`. It is a testing-only tool with no admin UI and no permissions: the endpoint stays completely inert until you opt in through settings flags (`$settings['drush_endpoint_enabled']`, plus `$settings['drush_endpoint_allow_uli']` for the one-time-login command), which are off by default. The maintainer's documentation is explicit that this is meant for isolated development and CI environments and must never be enabled on production. This version dir covers the pre-release **1.0.0-rc1**. Supports Drupal 10, 11, and 12; requires `drush/drush` `^12 || ^13`.

---

- Trigger `drush cron` from a Cypress test with a `POST` to `/api/drush/cron`.
- Rebuild caches during a test run with `POST /api/drush/cr`.
- Run a one-time-login link command (`uli`) from a test to log the browser in.
- Reset/re-run a Search API index from CI (`sapi-i`, `sapi-r`).
- Run or re-run migrations from a test harness (`mim`, `mr`).
- Give a Cypress suite a way to reach Drush when it runs in a different container than the web server.
- Drive Drupal maintenance tasks over HTTP where a CLI is unavailable to the test runner.
- Keep the endpoint switched off by default and enable it only per-environment via `settings.local.php`.
- Gate the whole endpoint behind `$settings['drush_endpoint_enabled'] = TRUE`.
- Separately opt in to the login command with `$settings['drush_endpoint_allow_uli'] = TRUE`.
- Restrict callable commands to the built-in seven-command allowlist.
- Read command results as JSON (`success`, `output`, `command`) returned by the endpoint.
- Log each executed command's success or failure to the `drush_endpoint` logger channel.
- Use it in DDEV/CI pipelines where the browser test tier and PHP tier are separate.
- Confirm the endpoint is live by POSTing to `cr` and checking the JSON response.
- Switch the endpoint back off after a test run by removing the settings flags.
- Firewall or otherwise restrict the `/api/drush/*` path to the environments that need it.
- Avoid enabling it on any public or production site (maintainer guidance).
- Support Drupal 10, 11, and 12 test environments.
