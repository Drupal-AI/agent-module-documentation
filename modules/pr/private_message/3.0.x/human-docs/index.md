# Private Message — manual setup guide

**Private Message** (`private_message`) adds a full user‑to‑user private messaging
system to Drupal. Logged‑in users hold threaded conversations through an on‑site
inbox — much like the direct messages on a social network — without any reliance on
email. Everything happens on the site: a user opens their inbox, picks or starts a
conversation, and reads and replies in a thread that updates over AJAX.

Under the hood the module works with two kinds of content: a **private message**
(one individual message, with an author, a body, and a timestamp) and a **private
message thread** (a conversation that ties several messages together and tracks its
members). Users reach their conversations at `/private-messages`, compose a new one
at `/private-message/create`, and read a specific thread at
`/private-messages/{id}`. The interface itself is assembled from **blocks** you
place — an inbox list, an unread‑count notification badge, and an actions block —
so you decide where messaging appears in your theme.

Beyond the basics, users can **block (ban)** each other so they no longer receive
messages, in either a passive or active mode, and you can customize almost all of
the wording (button labels, the blocked‑user message) and behavior (the key that
sends a message, the "away" idle threshold, whether to load the module's CSS) from
a single settings page. Developers get Views integration, hooks, a Rules action,
and a plugin type for adding their own sections to the settings page.

By default there are **no email notifications** — messaging is entirely on‑site.
The optional **Private Message Notify** (`private_message_notify`) submodule adds
email alerts when a user receives a new message.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, note the Message
   dependencies, and enable the optional email submodule.
2. [Configuration](configuration/index.md) — grant permissions, place the blocks,
   and tune the global settings page.

## Where it lives in the admin menu

The main settings form is at **Configuration → Private Message → Private Message
Config** (`/admin/config/private-message/config`). The blocks are placed at
**Structure → Block layout** (`/admin/structure/block`). Permissions are at
**People → Permissions**. The message and thread entities have Field UI base routes
under **Structure → Private message**.

## How to use it

Getting a working inbox involves three steps, all covered in
[Configuration](configuration/index.md):

1. **Grant permissions** — at minimum, give the roles that should message the
   **Use private messaging system** permission (plus core's *View user information*
   / access user profiles).
2. **Place the blocks** — add the inbox, notification, and actions blocks to your
   theme so users can reach and use their messages.
3. **Tune the settings** — adjust labels, the away threshold, the send key, and the
   blocking mode on the settings page, and optionally enable email notifications.
