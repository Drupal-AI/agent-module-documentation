<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Activity Emails sends a plain notification email to a configured address every time a node or user entity is created or updated.

---

The module has a single admin config form at `/admin/config/system/activity_emails` (permission `administer site configuration`). When enabled with a recipient address, its `entity_insert`/`entity_update` hooks fire for `node` and `user` entities only. The mail body is the configured template plus the entity URL and the acting user's name and email. Anonymous edits and entities without a canonical URL are skipped. Delivery relies entirely on the site's configured mail system (`hook_mail` key `upsert_entity`); nothing is queued, so a busy site produces one synchronous send per save.

Operationally it is a lightweight change-notification / low-fi audit tool rather than a full audit log — there is no per-content-type filtering beyond node/user, no digest, and no persisted record. The recipient field accepts a comma-separated list. Because the acting user's email is embedded in the message body, treat the recipient inbox as trusted.
---
Send an email whenever any node is created.
- Send an email whenever any node is updated.
- Notify an editor address about new user accounts.
- Notify on user profile updates.
- Configure a single recipient address for change notifications.
- Configure multiple recipients with a comma-separated list.
- Customize the notification template text.
- Include the changed entity's absolute URL in the email.
- Include the acting user's account name in the email.
- Include the acting user's email address in the email.
- Toggle notifications on or off without uninstalling.
- Use the site mail address as the From header automatically.
- Get a low-effort change feed for a small editorial team.
- Monitor a staging site for unexpected content edits.
- Skip notifications for anonymous edits automatically.
- Skip entities that have no canonical URL (e.g. paragraphs).
- Route notifications through the site's SMTP/mail transport.
- Disable emails temporarily during a bulk import.
- Restrict who can change the recipient via the config permission.
