# Message GC Notify — manual setup guide

**Message GC Notify** (`message_gcnotify`) connects Drupal's messaging stack to
**[GC Notify](https://notification.canada.ca/)**, the Government of Canada's
notification service, so that messages generated in Drupal are delivered as email
(and, through GC Notify, other channels) via that service. It plugs into the
[Message](https://www.drupal.org/project/message),
[Message Subscribe](https://www.drupal.org/project/message_subscribe) and
[Message Notify](https://www.drupal.org/project/message_notify) modules by
registering a new notifier called **GC Notify** that you can select on the Message
Subscribe configuration form.

The division of labour is deliberate: Drupal handles token replacement and
multilingual content, then posts the finished subject and body to a GC Notify
template that uses `((subject))` and `((body))` placeholders. GC Notify does the
actual sending. The module also ships an optional **QueueWorker** so that, on
high-volume sites, notifications can be throttled — queued and sent with a wait time
between items rather than all at once (pairing it with a cron runner such as Ultimate
Cron is recommended if you use the queue).

This module needs configuration before it will do anything: at minimum you must give
it the GC Notify **API endpoint URL**, a **template ID**, and an **API key**. Because
it sends recipient details (email/phone are personal data) and message content to an
external service and authenticates with a secret key, treat the setup with the care
that egress and credentials deserve — see [Configuration](configuration/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside the Message stack.
2. [Configuration](configuration/index.md) — enter the GC Notify URL, template ID and
   API key (stored as a secret), and optionally enable the queue.

## Where it lives in the admin menu

The GC Notify notifier is selected from the **Message Subscribe** configuration form.
The module's own connection settings (URL, template ID, API key, queue option) are
entered on its settings form; access is gated by the permission this module provides.
