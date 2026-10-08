<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Taxonomy Scheduler — agent index

Schedules **future-dated publishing of taxonomy terms** via a datetime field + cron. Version **2.0.2**. Core `^9.3 || ^10`.

Admin-only: settings at `/admin/config/taxonomy_scheduler` (permission `administer site configuration`). Cron event subscriber queues due terms; presave subscriber applies state. Depends on hook_event_dispatcher, core taxonomy, datetime. No public routes, no custom permissions.
