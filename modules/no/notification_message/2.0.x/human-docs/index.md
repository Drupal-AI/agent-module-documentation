# Notification Message — manual setup guide

**Notification Message** (`notification_message`) lets site administrators write
and broadcast site‑wide notifications — announcements, banners, and alerts — that
appear in a block for a scheduled window of time. Each message has a start and
end date, so it shows up automatically when its window opens and disappears again
when it closes, with no manual publishing or unpublishing. This makes it well
suited to maintenance notices, promotional banners, and emergency alerts.

Under the hood each notification is a small content entity, and notifications are
grouped into **message types** (bundles) — for example "Alert", "Promo", and
"Info" — which you can style differently and extend with your own fields (an
icon, a call‑to‑action link, a severity level) through Field UI. Message types
can also turn on a **dismiss** button so visitors can close a message, with the
choice remembered across sessions via a cookie. A message type ships out of the
box called *global* for generic notices.

Messages appear through the **Notification messages** block, which you place in
any region. The block shows only messages whose date window is currently open,
and each message can optionally be gated by Drupal's standard **Condition**
plugins (limit it to certain roles, certain paths, and so on), with a choice of
requiring all conditions or any of them. The module adds four permissions, uses
core's Block, Datetime, and Text modules, and requires **PHP 8.3**. There is no
single global settings page — you work with message types, the messages
themselves, and the block.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — message types, creating messages,
   placing the block, and permissions.

## Where it lives in the admin menu

There is no one settings form. The pieces live in three places:

- **Message types** — **Structure → Notification message types**
  (`/admin/structure/notification-message-types`).
- **Messages** — **Content → Notification messages**
  (`/admin/content/notification-message`).
- **The block** — **Structure → Block layout** (`/admin/structure/block`), where
  you place the *Notification messages* block.

## How to use it

At a glance: enable the module, place the **Notification messages** block in a
region, then add a message with a start and end date. It appears automatically
while its window is open. The [Configuration](configuration/index.md) page walks
through each step, including message types, conditions, and the dismiss button.
