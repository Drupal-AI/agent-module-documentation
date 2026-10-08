<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Workbench Email (workbench_email) — agent index

Sends **templated emails on content-moderation state transitions**. Version **3.0.x**.
Core `^10.5 || ^11 || ^12`, PHP `^8.0`. Depends on core `content_moderation`, `filter`.

Model: an **Email Template** config entity (`workbench_email_template`) carries a subject,
a text-format body, an optional Reply-To (all token-aware), a plain-text/HTML format, an
optional bundle allow-list, and a set of enabled **recipient type** plugins. Each template is
registered against workflow **transitions**. On a moderated entity save, the
`content_moderation.state_changed` event queues one email per resolved recipient (per
entity-type queue, flushed same-request; cron fallback), token-replaces + filter-renders the
body, and sends via the mail manager.

- **Create/manage templates, config keys, admin route** → [configure/templates.md](configure/templates.md)
- **Recipient type plugins (7 built-in) + write your own** → [plugins/recipient-types.md](plugins/recipient-types.md)
- **Permission that gates template admin** → [permissions/permissions.md](permissions/permissions.md)
- **Programmatic flow: event, queue, sending, hook_mail** → [api/services.md](api/services.md)
