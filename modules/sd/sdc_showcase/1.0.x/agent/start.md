<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SDC Showcase (sdc_showcase) — agent index

**Auto-generates preview/showcase pages (schema tables + variation matrices) for every Single Directory Component, rendered in the site theme, for QA and visual regression.**

- **Version:** 1.0.x  •  core `^10.6 || ^11`  •  PHP 8.1  •  package Development
- **Routes:** `sdc_showcase.settings` (`/admin/config/development/sdc-showcase`, perm `administer sdc showcase`); `sdc_showcase.index` `/sdc-showcase`, `.component`, `.variation`, `.collection` (all guarded by `_sdc_showcase_access`).
- **Permissions:** `access sdc showcase`, `administer sdc showcase`.
- **Plugin type:** `SdcDataGenerator` (fake-data providers). **Drush:** `sdc_showcase.commands`.
- **Security:** admin settings route permission-gated; public routes default to `access_mode: open` = require `access sdc showcase` permission. Credential modes (`http_auth`/`query_string`, `hash_equals`) are an explicit opt-in for anonymous CI/CD; `disabled` blocks all. Reviewed sound — no anonymous access unless an admin opts in.

See [configure/showcase.md](configure/showcase.md).