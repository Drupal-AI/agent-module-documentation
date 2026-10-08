# Mail Entity Queue — manual setup guide

**Mail Entity Queue** (`mail_entity_queue`) is a queue-based system for sending
email in a controlled, throttled way. Instead of firing every message off the
moment it's created, you enqueue messages and let the site drain the queue on a
schedule — a few at a time, with an optional delay between sends. That's useful
when you need to send in bulk without overwhelming your mail provider or tripping
rate limits.

The distinctive design choice is that **every queued message is an entity**. Each
queue is a configuration entity you create in the admin UI, and each message
waiting to be sent is a content entity you can inspect, edit, delete, or process
individually. A default processor sends items through Drupal core's email system;
other modules can supply alternative processors (for example integrating Symfony
Mailer), and each queue picks which processor it uses.

One important thing to know up front: **there is no UI for adding messages to a
queue.** You create the queue in the admin interface, but items are added
*programmatically* by your own code (or another module) calling the queue's
`addItem()` method. So this module is aimed at developers building a controlled
sending flow, not at content editors composing one-off emails. It depends on
core's Options and System modules, provides its own permissions, and supports
Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — create a queue, tune its throttling,
   and manage queued items.

## Where it lives in the admin menu

- **Queues** are created and configured at **Configuration → System → Mail entity
  queues** (`/admin/config/system/mail-entity-queue`).
- **Queued messages** are managed at **Structure → Mail queue items**
  (`/admin/structure/mail-entity-queue`), where you can view, edit, delete, or
  process each item individually.

## How it fits together

1. You create one or more **queues** in the admin UI and set their throttling
   limits.
2. Your code (or another module) loads a queue by its machine name and adds
   items to it — each item carries the recipient, subject, body, and headers.
3. On each **cron run**, the queue's processor sends up to the configured number
   of items, honouring the delay between them. Because sending happens on cron,
   a reliable cron setup (core cron, or a tool like Ultimate Cron) matters.

A short security note worth keeping in mind: a system that sends email in bulk is
powerful, so make sure only trusted code paths enqueue mail, keep the queued
content trusted, and grant the module's permissions only to trusted operators — a
bulk mailer should never become an open relay for spam.
