<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CiviCRM User Synchronisation (cmrf_user_sync) — agent index
**Creates/updates/blocks/deletes Drupal users from CiviCRM change messages via CiviMRF, processed on cron.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10 || ^11
- **Requires:** cmrf_core (CiviMRF)
- **Route:** `cmrf_user_sync.cmrf_user_sync_config_form` → `/admin/config/cmrf_user_sync/usersyncconfig` (`_permission: access administration pages`)
- **QueueWorker:** `cmrf_user_sync_queue` (cron; actions `get` → enqueue messages, `process` → apply)
- **Processors (plugins):** `cmrf_basic_user_sync` (BasicUserProvider), `cmrf_portal_user_sync` (PortalUserProvider — roles + delete/block policy)
- **User field:** `field_user_contact_id` (write access limited to `administer users`)
- **Security:** ⚠ The config form that controls account creation, **role granting**, and **deletion** is gated only by `access administration pages` (routing.yml) — under-privileged for its impact; recommend `administer users`. Data source is CiviCRM (trusted upstream). Admin-role users are protected from delete/block. Created users have no password set.

See [configure/sync.md](configure/sync.md)