# Chat Messenger — manual setup guide

**Chat Messenger** (`chat_messenger`) adds a complete real‑time messaging system
between site users, built entirely on the standard Drupal stack. Instead of just a
basic private‑message form, it gives you a modern chat experience: one‑to‑one
conversations, group chats, live message delivery, typing indicators, emoji
reactions, presence status, read receipts, unread badges, profile‑picture avatars,
and image/file attachments — a floating chat button follows users around the site.

The key selling point is that it needs **no separate chat server**: no WebSocket
service, no Node.js, no Redis, no third‑party platform. Live updates are delivered
by AJAX long‑polling, so everything runs on a normal Drupal hosting stack. It
depends on Drupal core's **User**, **File**, and **Image** modules and on the
[Flag](https://www.drupal.org/project/flag) module.

It works as soon as you enable it and grant permissions — there is no central
settings form. Optionally, if you enable the **AI** module and configure a
chat‑capable provider, Chat Messenger can offer AI‑generated quick‑reply
suggestions; this is entirely optional and unused otherwise. Because the module
stores private messages (personal data) and accepts file attachments, plan for
privacy and retention: the system is designed so a user only reads their own
conversations, and attachments use private file storage — configure your site's
private file system and per‑user picture field for the best, most secure
experience. Note this branch is minimally maintained (maintenance fixes only).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant chat permissions.

There is **no central configuration form** for this module — you enable it, grant
permissions, and it runs. See "How to use it" below.

## How to use it

After the module is enabled and roles have the appropriate chat permissions:

1. Users automatically see a **floating chat button** while browsing the site.
2. Clicking it shows available users and existing conversations.
3. From there they start a private conversation or create a new group chat, send
   messages and attachments, react with emoji, and set their presence (Available,
   Busy, or Away).

For the best experience, configure user **profile pictures** (used as chat avatars;
initial‑based avatars are generated automatically when none exists) and the
**private file system** so uploaded attachments are stored securely. Upload size
and allowed file types for attachments are configurable.
