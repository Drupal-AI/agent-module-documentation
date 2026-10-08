# SMS System — manual setup guide

**SMS System** (`smssystem`) is a service and toolset for sending SMS messages
from Drupal, typically **triggered by events** — for example when content is
published, an order changes status, or a custom event fires. It talks to an SMS
gateway on your behalf and gives you templates, logging, and queueing around the
sends. Other code sends messages through its internal service, so it's the
sending layer that features build on rather than a visitor‑facing feature.

Its main capabilities are: sending an SMS via a defined **template** (with token
support, so message text can include dynamic values); **logging** every sent SMS
and exposing that log through Drupal **Views** (so you can filter, paginate, and
export the history); a **queue** so that on high‑load sites messages are sent in
the background via cron; and a **Test mode** that lets you exercise the flow
without spending money on real sends — handy for local development. It has been
tested with the InterMobcom gateway and can also work with BulkSMS, PROCONTEXT, and
EMOTION TRADING.

The module depends on **Date popup** and, as documented, works with **Token**,
**Views**, and **Views data export**. It provides its own permissions.

A few security points to keep in mind, since this module sends real SMS: it
authenticates to an SMS gateway with **credentials** — store those as secrets (an
environment variable or a Key entity), not in plain exported config. Because every
message **costs money**, make sure your event triggers can't be abused to fire off
mass or unwanted SMS — a public‑facing action that triggers a send is a potential
spam / cost‑abuse vector, so gate it carefully. And recipient **phone numbers are
personal data**, so handle them with appropriate consent and privacy care.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (plus its dependencies).
2. [Configuration](configuration/index.md) — the admin and API settings,
   templates, reporting, and the queue.

## Where it lives in the admin menu

SMS System's screens sit under **`/admin/config/system/smssystem`**:

- **Main settings** — `/admin/config/system/smssystem`
- **API settings** — `/admin/config/system/smssystem/api`
- **SMS message templates** — `/admin/config/system/smssystem/templates/list`
- **Reporting** — `/admin/config/system/smssystem/reporting`
- **SMS queue list** — `/admin/config/system/smssystem/sms-queue-list`

## How to use it

Once configured, custom code sends messages through the `smssystem.send_sms`
service. For example, to send a simple message immediately:

```php
$sms_service = \Drupal::service('smssystem.send_sms');
$sms_service->sendSms('+37369123456', 'Hello!');
```

To send via a named template, or to push the send onto the queue (processed by
cron) instead of sending straight away:

```php
// Send using a template defined at /admin/config/system/smssystem/templates/list
$sms_service->sendSmsByTemplate('order_completed', '+37369123456');

// Queue a send (third argument TRUE) for background processing via cron.
$sms_service->sendSms('+37369123456', 'Hello!', TRUE);
$sms_service->sendSmsByTemplate('order_placed', '+37369123456', TRUE);
```
