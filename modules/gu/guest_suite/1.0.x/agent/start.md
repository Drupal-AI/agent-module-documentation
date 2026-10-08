<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Guest suite — agent index

Integrates the **Guest Suite reviews** SaaS: `guest_suite_review` entity, REST **API consumer**, cron import queues, and rating tokens. Version **1.0.0**. Core `^8.7.7 || ^9 || ^10`.

- Config: `/admin/config/services/guest-suite` (route `guest_suite.configuration`, `administer site configuration`).
- `ApiConsumer` (`src/ApiConsumer.php`) → `https://wire.guest-suite.com/rest/`, HTTPS with `access_token` query param from `guest_suite.settings`.
- Deps: entity, datetime, views, link, block. The access token is stored in `guest_suite.settings` config.
