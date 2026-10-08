# Simple Content Notifications — manual setup guide

**Simple Content Notifications** (`simple_content_notifications`) emails a
notification when content is added, edited, or deleted, and can also send a
periodic notice listing content that has gone too long without being reviewed. It
is intentionally small — the kind of tool you reach for when a full workflow
engine like ECA, Rules, or Workflow would be more machinery than a single
notification requirement deserves.

The module does two distinct jobs. **Content CRUD notifications** send an email to
one or more addresses when content of selected types is created, updated, or
deleted. **Content review notifications** watch a "last reviewed" date stored in a
field you nominate, and periodically send a single digest listing every item whose
review is overdue — plus an admin page at **Content → Needing review**
(`/admin/content/needing_review`) that lists the same items for anyone with the
*Administer content* permission. Both halves are configured through their own
settings forms and gated by a dedicated *Administer Content Notifications*
permission. It has no other module dependencies.

A few things are worth settling before you turn it on, because they apply to any
notification tool. **Volume:** emailing on every change to every content type
quickly trains people to ignore the mail, so scope it to the types and transitions
that matter. **Delivery:** mail sent while content is being saved ties editing to
your mail server — if a slow SMTP host is in the path, saves can feel slow.
**Recipients:** a notification that carries content excerpts is a copy of that
content leaving the site's access controls, which matters if the content is
restricted. And remember email is a poor queue: for "needs review", the on‑site
listing is a more reliable source of truth than a message someone may have
archived.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the two settings forms (change
   notifications and review notifications), field by field.

## Where it lives in the admin menu

After enabling, its two settings forms sit under **Configuration → Content
authoring**:

- Change notifications:
  `/admin/config/content/simple_content_notifications/settings`
- Review notifications:
  `/admin/config/content/simple_content_notifications/needing_review_settings`

The review listing is at **Content → Needing review**
(`/admin/content/needing_review`).
