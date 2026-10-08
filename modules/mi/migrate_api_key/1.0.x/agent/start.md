<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migrate API Key — agent index

**Adds a migration plugin that appends an API key to URL-sourced migration GET requests**. Depends on `migrate`,
`migrate_plus`. Version **1.0.0**. Core `^11`.

Import/migration — the **API key goes in the URL query string** (logs/history/referrer risk): treat it as
sensitive, prefer header-based keys, store as a secret, HTTPS. No access role.
