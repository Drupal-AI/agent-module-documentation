# Dismissible Message Bar — manual setup guide

**Dismissible Message Bar** (`dismissible_message_bar`) lets site builders create
notification bars — announcements, maintenance notices, promotions — that appear
across the site and that visitors can close. Each message is built from
**Paragraphs**, so you can compose rich content (text, buttons, images) using any
Paragraph types you allow. Once a visitor dismisses a bar, a browser cookie
remembers their choice so the same message won't nag them again.

Each notification is a content entity you create and edit like any other content.
You control exactly where and when it shows: target specific paths (with `*`
wildcards) or exclude paths, limit it to certain content types, mark it sitewide,
and give it a start/end date range so it appears and disappears automatically on
schedule. You can let visitors dismiss it and remember that dismissal for a set
number of days, force it to reappear on every page load, or auto-dismiss it after
a few seconds.

To display notifications you place the **DMB Notifications block** in a region.
The block can optionally be scoped to a single notification *type* (a taxonomy
term), so you can run several bars in different regions, each showing a different
category of message. The heavy lifting of "which bars show on this page right
now" happens in the browser based on path, content type, and date, which keeps
the feature compatible with page caching.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   Paragraphs and Datetime Range dependencies) and enable the module.
2. [Configuration](configuration/index.md) — create a notification, fill in its
   targeting/cookie/date fields, and place the block.

## Where it lives in the admin menu

- **Create a notification:** `/dmb_notifications/add` (pick a type, fill fields,
  save).
- **Notification types (bundles):** **Structure → DMB Notification types**
  (`/admin/structure/dmb_notification_types`) — gated by the trusted-admin
  **`administer dmb notifications entities`** permission.
- **Place the block:** **Structure → Block layout** (`/admin/structure/block`) —
  add the **DMB Notifications block** to a region.

Access is permission-gated per operation (add / edit / delete / view published /
view unpublished / view revisions) at **People → Permissions**. The
add/edit/delete/view permissions are *not* restricted, so you can safely grant a
content-editor role the ability to author notifications without full admin
access — much like letting them edit a block or a node body.
