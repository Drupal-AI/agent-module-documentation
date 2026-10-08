# Gammu SMS Daemon — manual setup guide

**Gammu SMS Daemon** (`gammu_smsd`) lets your Drupal site send and receive SMS
messages through the [Gammu SMSD](https://wammu.eu/smsd/) backend — the SMS daemon
that talks to a physical GSM modem or gateway. It gives editors a web interface
for composing messages and sending them to a list of phone numbers (for example a
"client" content type with a telephone field), plus an inbox/sent view, and it
exposes an HTTP endpoint so that incoming/outgoing SMS can be handled
programmatically. Messages can use simple variables like `Dear {{name}}...`.

> ## ⚠️ Read this before you install
>
> **This module is marked *Unsupported*, and its security advisory coverage has
> been *revoked*, because of a security issue the maintainer did not fix.** Do not
> deploy it on a production or internet‑facing site as‑is. The Drupal project's
> guidance is to choose an actively maintained SMS module instead, or — if you
> must use this one — to follow the unsupported‑project process and have the
> security bug fixed first.
>
> **The specific risk (inbound HTTP endpoint):** as shipped (`8.x-1.2`), the send
> API at **`api/gammu/send`** is declared with `_access: 'TRUE'` — meaning Drupal
> itself does not require any permission to reach it. The route tries to
> authenticate a caller by comparing the request's `Authorization` header against a
> configured token (`gammu_token`) using a **loose `==`** comparison. Because
> `gammu_token` is **empty by default**, a request that sends *no* `Authorization`
> header is compared as `null == null`, which passes. The practical result: **until
> you set a token, an anonymous attacker can call the endpoint and send arbitrary
> SMS through your gateway** — real messages that cost real money, and a vector for
> spam or phishing sent in your name.
>
> **If you use it anyway, at minimum:**
> - **Set a strong, random `gammu_token`** immediately after install, so the empty
>   default can never be matched.
> - **Restrict the `api/gammu/send` route** at the web‑server or firewall level to
>   only the trusted systems that need it (an allow‑list of source IPs, or an
>   internal‑only network path).
> - Treat sending SMS as billable: monitor usage and rate‑limit upstream if you
>   can.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install Gammu SMSD on the server,
   install and enable the module.
2. [Configuration](configuration/index.md) — connect to the Gammu database, set
   the send token, and harden the inbound endpoint.

## Where it lives in the admin menu

The admin interface (compose/send, inbox/sent) is gated by the **administer
gammu** permission, managed at **People → Permissions**. The inbound send API is
at **`api/gammu/send`** — see the security notes above and in Configuration.

## How to use it

1. Make sure **Gammu SMSD** is installed and configured on your server with a
   working modem/gateway (see Installation).
2. Point the module at the Gammu SMSD database and **set a strong send token**
   (see Configuration).
3. Build your recipient list — for example a content type such as *Client* with a
   telephone field — and map name fields for personalisation variables.
4. Compose a message in the module's interface (using variables like
   `Dear {{name}}...` if you like), select recipients, and send.
