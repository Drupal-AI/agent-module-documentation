# SMS.ru — manual setup guide

**SMS.ru** (`smsru`) is a gateway plugin that lets Drupal's **SMS Framework**
send text messages — and read balance and delivery reports — through the
**SMS.ru** HTTP API, a Russian SMS provider. It doesn't send SMS on its own; it
registers an `smsru` gateway that the framework can route messages through. Once
the framework is installed and you've added this gateway and set it as default,
any Drupal feature that sends SMS delivers via SMS.ru.

Alongside the gateway, the module ships a rich standalone **API client** class
(`\Drupal\smsru\SmsRu`) for developers, which wraps the wider SMS.ru surface:
checking message cost, daily and free limits, listing approved sender names,
managing the stop list, registering delivery callback URLs, and running call‑check
verification. Most site builders won't need that — the gateway is the part you
configure through the UI.

A note on dependencies: the module's own `.info.yml` only declares a core
dependency, but in practice the **SMS Framework** (`drupal/sms`) is a required
runtime companion — the `smsru` gateway plugin plugs into it and isn't usable
without it. There is no admin settings page of the module's own; you configure
everything on the SMS Framework gateway form.

On security the module is sound: requests go over **HTTPS** to `https://sms.ru`
via Guzzle with TLS verification left at its secure default (no disabled
verification). You authenticate either with an **API ID** (recommended) or a
**login + password**; whichever you choose, credentials are stored in Drupal
`state`, shown as masked/password fields, and there's a "forget credentials"
toggle to wipe them. A test mode lets messages appear in your SMS.ru account
without actually being dispatched.

This guide is written for a **human** setting the gateway up through the admin UI.
If you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (plus its SMS Framework companion).
2. [Configuration](configuration/index.md) — add the SMS.ru gateway and choose an
   authentication method.

## How to use it

After you configure an SMS.ru gateway (see [Configuration](configuration/index.md))
and set it as the SMS Framework default, any feature that sends SMS through the
framework — password resets, 2FA codes, notifications — delivers via SMS.ru. The
gateway maps SMS.ru's status codes to framework delivery statuses (queued,
delivered, expired, rejected, invalid recipient, and so on), can report your
account credit balance, and can set a custom sender name.
