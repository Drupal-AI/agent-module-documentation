# SMS Strex — manual setup guide

**SMS Strex** (`sms_strex`) registers the Norwegian **Strex / Target365** SMS
service as a gateway for Drupal's **SMS Framework**. Strex (owned by mobile
operators Telenor, Telia, and Ice) runs the *Strex Connect* platform for incoming
and outgoing SMS; this module lets Drupal send messages through it. It doesn't
send SMS on its own — it adds Strex as one more gateway the framework can route
messages through, so once it's configured and selected, any SMS the framework
dispatches is delivered via Strex Connect.

Under the hood the module wraps the official **`target365/api-sdk`** PHP client
and signs each request with a key name and private key that you configure on the
gateway. It ships an install‑time requirements check (so Drupal warns you if the
SDK library is missing) and an alter hook that lets other modules tag outbound
messages. It depends on the **SMS Framework** module (`smsframework`, machine name
`sms`) and has no config forms, routes, or permissions of its own — everything is
configured through the SMS Framework gateway UI.

On security, the module is sound: it talks to Strex over hard‑coded **HTTPS**
endpoints (`https://shared.target365.io` for live, `https://test.target365.io` for
test), and the SDK handles Target365's signed‑request authentication — TLS is not
disabled. Your API key name and private key are the secret to protect; they live
in the gateway configuration rather than in code. A helpful test mode lets you try
things safely without messaging real users (see below).

This guide is written for a **human** setting the gateway up through the admin UI.
If you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   Target365 SDK) and enable the module.
2. [Configuration](configuration/index.md) — add the Strex gateway, enter your
   Target365 keys, and set live/test mode.

## How to use it

After you configure a Strex gateway (see [Configuration](configuration/index.md))
and set it as the SMS Framework default, any feature that sends SMS through the
framework delivers via Strex — OTPs, transactional messages, or campaigns, to any
number of recipients per message. Strex's own dashboard at `strexconnect.no` then
gives you statistics and delivery overview. You can tag outbound messages (for
Target365 reporting) via the gateway's tags field, and other modules can add or
alter those tags programmatically.
