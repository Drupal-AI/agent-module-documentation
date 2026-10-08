<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# YMCA Sync suite — agent index

Web services to **sync data with YMCA systems** (Open Y / YMCA platform — memberships/programs/
schedules). Provides **Drush commands**. Version **11.0.0**. Core `^10||^11`.

**Security:** store external-system credentials as secrets; synced data may include member **PII** —
access-control and privacy care. Typically run via Drush/cron.
