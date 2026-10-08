# Message — manual setup guide

**Message** (`message`) is the foundation of Drupal's "message stack" — a general
utility for logging and displaying system events over time. Those recorded events
are often called an **activity stream**: "Alice created an article," "Bob joined
the group," "a comment was posted." Message gives you a flexible, fieldable,
exportable way to define what those events look like and to store one record each
time they happen.

The core idea is a **message template** (a config entity — the reusable definition,
with its text, fields, and settings) versus a **message** (a content entity — one
logged instance of a template). You build templates in the admin UI, add fields to
them with Field UI, and write their text as one or more token-aware "partials" that
can be displayed together or individually. Templates support view modes, multiple
languages, and full token replacement.

On its own, Message logs and models events but doesn't send or subscribe to
anything — that's what the rest of the stack is for: **Message Notify** (forward
messages when generated), **Message Subscribe** (let users subscribe to
notifications), **Message Digest** (aggregate and send digests), and **Message UI**
(a ready-made CRUD interface for message content). Message itself ships one
submodule, **Message Example**, with sample templates to learn from. It depends
only on core's **Text** module.

Because messages accumulate over time, Message also includes **purge** settings so
old records can be automatically deleted (by age or quota) on cron, and an option
to delete messages when the entity they reference is deleted.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and optionally the example submodule.
2. [Configuration](configuration/index.md) — global settings (purge and
   auto-delete) and creating message templates.

## Where it lives in the admin menu

Message spreads across two areas:

- **Configuration → Message** (`/admin/config/message`, route
  `message.main_settings`) — the settings hub, including the global settings form
  for purging and auto-delete.
- **Structure → Messages** (`/admin/structure/message`, route
  `message.overview_templates`) — where you create and manage message templates and
  their fields/display.

Template administration requires the **Administer message templates** permission;
message content is governed by **Administer messages** and **Overview messages**.

## How to use it

Define a template for each kind of event you want to record (giving it fields and
token-aware text), then generate a message from that template whenever the event
occurs (typically in code, or via another module in the stack such as Message
Notify or Message Subscribe). Stored messages can be rendered through view modes,
listed with Views, and purged automatically as they age.
