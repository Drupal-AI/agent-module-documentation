# Fast2sms — manual setup guide

**Fast2sms** (`sms_fast2sms`) is a gateway plugin that lets Drupal's **SMS
Framework** deliver outbound text messages through the **Fast2SMS** bulk SMS API,
a popular service for sending SMS to Indian mobile numbers. The module doesn't
send SMS on its own; it registers Fast2sms as a gateway that the framework can
route messages through. Once you've created the gateway and set it as the site
default, any SMS the framework dispatches — OTPs, notifications, bulk sends — goes
out through Fast2SMS.

The module depends on the **SMS Framework** module (`smsframework`, machine name
`sms`) and has no other external dependencies; setup is simply a matter of adding
your Fast2SMS API key. It is minimally maintained (maintenance fixes only), and
its maintainers are not affiliated with the Fast2SMS group.

Messages are sent over **HTTPS** to the fixed endpoint
`https://www.fast2sms.com/dev/bulkV2` with Guzzle's default TLS verification left
on. Your **API key is stored in the gateway configuration** — the standard SMS
Framework pattern (it does not use a Key entity) — so protect your exported
configuration accordingly.

This guide is written for a **human** setting the gateway up through the admin UI.
If you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (plus its SMS Framework dependency).
2. [Configuration](configuration/index.md) — create the Fast2sms gateway and
   enter your API key, route, and sender id.

## How to use it

After you install the module and configure a Fast2sms gateway (see
[Configuration](configuration/index.md)), set it as SMS Framework's default
gateway. From then on any feature that sends SMS through the framework will
deliver via Fast2SMS. You can send a test message to a single recipient to
confirm connectivity, and successful sends return message ids that the framework
records as delivery reports.
