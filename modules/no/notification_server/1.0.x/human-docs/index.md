# Notification Server — manual setup guide

**Notification Server** (`notification_server`) gives Drupal real‑time
notification capabilities by talking to an external notification server over
**HTTP and WebSocket**. With it in place, your site can push live messages to
connected browsers or apps — the kind of thing you want for activity feeds,
alerts, chat, and live dashboards — instead of relying on the visitor to reload
the page.

It is important to understand up front that this is a **developer module**. It
does nothing on its own: it provides APIs and services (notably the
`notification_server.client` service) that your own custom code — or another
module — calls to publish notifications and manage channels. There is no admin
screen that produces notifications for you.

It is also a **self‑hosted** approach. Rather than paying for a SaaS real‑time
messaging service such as Pusher, Firebase, or Ably, you run your own
notification server, keeping full control of your data and avoiding vendor
lock‑in. That does mean there are moving parts beyond Drupal: the module
requires a running instance of the companion **Notification Server** (or a
compatible API), and that server in turn requires **Redis** for data storage.
The connection to it should be secured and its clients authenticated.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   stand up the companion server (the DDEV add‑on makes this easy), and enable
   the module.

This module has **no configuration form** in the admin UI (`configure` is null).
Everything it does happens through code that calls its services, so setup and use
are covered on the Installation page and in "How to use it" below.

## How to use it

Once the module is enabled and the companion server is running, you publish
notifications from custom code through the client service:

```php
$notification_client = \Drupal::service('notification_server.client');
$notification_client->publishNotification('channel_name', 'Hello, World!');
```

Browser clients connect over WebSocket to receive messages on the channels they
have access to. Because the module reaches an external server, treat its
connection details and any API credentials as **secrets** — store them in an
environment variable (with DDEV, `ddev dotenv set .ddev/.env --notification-…=<value>`
then `ddev restart`) rather than committing them, and always connect over a
secure (TLS) endpoint. Authenticate WebSocket clients so that a user only
receives the notifications they are entitled to see.
