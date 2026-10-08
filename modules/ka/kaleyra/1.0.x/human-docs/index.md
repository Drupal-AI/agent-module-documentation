# Kaleyra — manual setup guide

**Kaleyra** (`kaleyra`) is a small integration that sends **SMS text messages**
through the [Kaleyra](https://www.kaleyra.com/) Global Messaging API. It gives your
site one thing: a service that other code can call to send a message — perfect for
transactional notifications, one‑time passwords, or verification codes triggered by
your own workflows.

There is no message‑composing UI and no public routes for sending. Instead the
module exposes an injectable service, `kaleyra.sms_api_adapter`, whose
`send($to, $message)` method fires an HTTP request to Kaleyra with your sender ID,
the recipient, the message text, and your API key. It's fire‑and‑forget: failures
are caught and written to the `kaleyra` log channel rather than surfaced to the
caller. A settings form lets an administrator enter the connection details.

The only sensitive part is your **API key**, which is stored in configuration and
sent to Kaleyra over TLS. Because it lives in config, treat your configuration
exports as sensitive and prefer supplying the key from the environment (see
[Configuration](configuration/index.md)). The module has no access‑control role and
sends outbound only. The maintainers note a longer‑term plan to make it compatible
with the SMS Framework project.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — enter your Kaleyra API domain, key,
   sender ID, and unicode mode, and secure the key.

## Where it lives in the admin menu

The settings form is at **`/admin/config/kaleyra`** (route `kaleyra.settings`),
gated by the **administer kaleyra config** permission.

## How to use it

Sending is done from code, not the UI. Fetch or inject the service and call
`send()`:

```php
/** @var \Drupal\kaleyra\MessageApiAdapter $sms */
$sms = \Drupal::service('kaleyra.sms_api_adapter');
$sms->send('+15551234567', 'Your code is 123456');
```

The call reads your saved settings and issues the request to Kaleyra. There is no
return value or delivery confirmation — check the `kaleyra` log channel if a message
doesn't arrive.
