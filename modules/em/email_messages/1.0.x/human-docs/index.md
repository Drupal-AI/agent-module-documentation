# Email Messages — manual setup guide

**Email Messages** (`email_messages`) is a small utility module for developers. It
provides a **configuration entity** for storing — and translating — the messages
your site sends out as email notifications, so notification copy lives in one
managed place rather than being scattered through code. It can also log the emails
it sends to a separate entity, giving you a record of what went out.

Alongside the stored messages, the module includes a **manager** that loads a
message's configuration, replaces variables in it, and sends the email. In
practice you define your reusable messages once, then have your own code call the
manager to render and send them — which keeps the wording out of your codebase and
makes it translatable.

This is explicitly a **developer utility**: it gives you the storage, translation,
logging, and sending plumbing, and you wire it into your own flows. It depends
only on Drupal core's **Text** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

This module is a developer building block rather than a click‑through feature; it
has no general settings form, so there is no separate configuration page in this
guide.

## How to use it

Email Messages is meant to be driven from code. The typical shape is:

1. Create the reusable message configuration entities that hold your notification
   copy (and, if needed, their translations).
2. From your own module, call the module's message manager, passing the variables
   to substitute; the manager loads the message, replaces the variables, and
   sends the email.
3. Optionally review the log entity to see which emails were sent.
