<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Twilio (twilio) — agent index

Twilio SMS integration: settings form, test-send form, per-user phone verification, message log.
Configure at `/admin/config/system/twilio`. Version **8.x-3.0-alpha17** (2024).
Core requirement `^8 || ^9 || ^10 || ^11`.

**Maturity.** An **alpha** from 2024. The four-major core range is a declaration, not evidence
of testing.

Per-user phone verification lives at `/user/{user}/edit/twilio` (`UserSettingsForm`), route
permission `access twilio`.

Permissions: `administer twilio` (`restrict access: TRUE`, gates both admin routes),
`access twilio`, `access twilio log`.

**Credentials.** The account SID and auth token live in configuration. An auth token is a live,
billable credential — put it in an environment variable and reference it through a **Key** entity
rather than letting it reach an exported config file.
