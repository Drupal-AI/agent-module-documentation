# SMS Rangine — manual setup guide

**SMS Rangine** (`sms_rangine`) is a single‑plugin bridge that registers the
Iranian **Rangine** SMS service (`sms.rangine.ir`) as a gateway for Drupal's
**SMS Framework**. It doesn't send SMS on its own; it adds Rangine as one of the
gateways the framework can route messages through. Once enabled and configured,
any SMS the framework dispatches can be delivered via your Rangine panel —
including Rangine's **pattern (template)** sends, which are the fast way to send
pre‑approved message templates.

The module depends on the **SMS Framework** module (machine name `sms`) and adds
no routes, services, permissions, or blocks of its own. To use it you'll need a
Rangine web‑service or professional panel at `sms.rangine.ir`, from which you get
the username, password, and sender line you enter on the gateway. It is minimally
maintained (maintenance fixes only).

**One transport caveat is worth calling out.** By default the gateway's **host**
setting is `sms.rangine.ir` with **no URL scheme**, which causes the underlying
cURL request to fall back to plain **HTTP** — and in *pattern* mode the account
username and password are sent as **URL query parameters**. That means your
Rangine credentials could travel over the network in cleartext. The fix is
simple: set the **host** field to `https://sms.rangine.ir` so the connection uses
HTTPS. These are your own outbound account credentials (configured by an admin),
so the exposure is at the transport layer rather than an anonymous‑abuse route,
but it's still worth fixing before you send real traffic.

This guide is written for a **human** setting the gateway up through the admin
UI. If you want terse, token‑cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (plus its SMS Framework dependency).
2. [Configuration](configuration/index.md) — add the Rangine gateway and enter
   your username, password, sender line, and host.

## How to use it

After you configure a Rangine gateway (see [Configuration](configuration/index.md))
and set it as the SMS Framework default, any feature that sends SMS through the
framework delivers via Rangine. You can send a plain text message to a recipient,
or a **pattern** message (a body beginning `pcode:` or `patterncode:`) to use a
Rangine template with variables. A debug option lets you preview the outbound
message on screen instead of actually sending it. Delivery outcomes are mapped
back to SMS Framework statuses, with Rangine's numeric error codes translated
into human‑readable (Persian) messages.
