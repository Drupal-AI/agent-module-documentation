<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Activity Emails (activity_emails) — agent index

**Emails a configured address on node/user create and update.**

- **Version:** 1.x (dev-1.x; latest tagged release series 8.x-1.7)
- **Core:** ^8 || ^9 || ^10 || ^11 || ^12
- **Config route:** `activity_emails.activity_emails_form` → `/admin/config/system/activity_emails`
- **Permission:** `administer site configuration` (uses core; no custom permissions)
- **Config keys:** `enabled`, `email`, `template` (`activity_emails.settings`)
- **Hooks (src/Hook/ActivityEmailsHooks.php):** `entity_insert`, `entity_update`, `mail` (key `upsert_entity`); only `node` and `user` entity types trigger mail.
- **Delivery:** synchronous `MailManager` send; no queue.

**Security:** admin config route is permission-gated (`administer site configuration`); no anonymous or mutating endpoints. No external calls, no TLS surface. Note the acting user's email is placed in the mail body — keep the recipient inbox trusted.
