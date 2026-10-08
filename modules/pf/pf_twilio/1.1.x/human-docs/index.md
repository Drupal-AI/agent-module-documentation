# Push Framework Twilio — manual setup guide

**Push Framework Twilio** (`pf_twilio`) adds [Twilio](https://www.twilio.com/) SMS
as a delivery channel for the
[Push Framework](https://www.drupal.org/project/push_framework) module. With it
enabled, notifications you send through the Push Framework can be delivered as text
messages to your users' phone numbers, extending "push" beyond apps and browsers to
plain SMS.

It slots in next to the Push Framework's other channels: you configure your Twilio
account credentials, and the framework can then route messages through Twilio when
you choose the SMS channel. It depends on the Push Framework module and core's User
module.

Two practical notes before you rely on it. First, this is an early **beta** release
(1.1.0‑beta1) and the maintainers describe it as still coming together, so expect
some rough edges. Second, **Twilio charges per message** — every SMS sent costs
money against your Twilio balance, so keep an eye on volume.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Push Framework.
2. [Configuration](configuration/index.md) — supply your Twilio credentials and
   store them safely.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Enter your Twilio account credentials and sending number (see
   [Configuration](configuration/index.md)).
3. Enable the **Twilio** channel within Push Framework's own settings so the
   framework uses it for SMS delivery.

Users must have a phone number stored that the channel can send to. From then on,
notifications routed through the Twilio channel are delivered as SMS.
