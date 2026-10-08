# Notifications Widget — manual setup guide

**Notifications Widget** (`notifications_widget`) adds the bell icon familiar
from social platforms: a dropdown that lists recent activity relevant to a user,
topped with a red unread‑count badge. Notifications can be read, marked unread,
deleted individually, or cleared all at once — the everyday interactions people
expect from a notification tray.

Under the hood the module **logs events** and renders them through a **block**.
Other modules feed it by calling a logging service
(`notifications_widget.logger`) — for example `views_kanban` logs a notification
when a card moves. The messages themselves support **token replacement** such as
`[user:name]`, `[node:title]`, or `[comment:entity:title]`, so a logged event can
read as a natural sentence. You can extend which entities are tracked (profiles,
paragraphs, and more), and it integrates with **Views** for node, comment, term,
profile, and message.

One technical detail shapes how it behaves: the widget depends on core **REST**
and fetches its notifications over a REST endpoint rather than rendering them
server‑side. That is what lets the unread count update without a page reload —
but it also means core REST is enabled on your site once this module is on.

Two practical notes before you start. First, the **project name and module name
differ**: the project is `notificationswidget` but the module you enable is
`notifications_widget` (with an underscore) — this matters for `drush en`.
Second, the release documented here is an **alpha** (2.0.0‑alpha9), so treat it
accordingly on production sites. The module's own docs also stress that you must
**save its configuration once after installing**, and that a Bootstrap theme or
equivalent CSS should be present for the dropdown to look right.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (mind the
   project‑vs‑module name), enable it, and place the block.
2. [Configuration](configuration/index.md) — the general settings and the logger
   settings, plus placing and styling the bell block.

## Where it lives in the admin menu

Notifications Widget has two settings forms, both requiring *Administer site
configuration*:

- **General settings** — **`/admin/config/system/notifications_widget`**
  (route `notifications_widget.notifications_widget_settings`).
- **Logger settings** — **`/admin/config/people/notifications_widget/loggers`** —
  where you choose which events get logged.

The bell itself is a block you place through **Structure → Block layout**.
