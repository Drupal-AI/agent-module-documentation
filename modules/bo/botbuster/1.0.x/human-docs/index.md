# BotBuster — manual setup guide

**BotBuster** (`botbuster`) protects paths you choose with a lightweight
**JavaScript browser-verification challenge**. Before serving a protected path, it
asks the client to pass a small JS challenge. Simple automated bots — which often
do not run JavaScript — fail it, so basic scrapers and abusive automation get
filtered out without confronting real visitors with a full CAPTCHA.

It is a low-friction anti-abuse layer, best pointed at sensitive or expensive
paths such as forms or costly endpoints. You choose which paths are protected in
its settings form.

Be clear about what a JavaScript challenge can and cannot do. It stops naive bots
that do not execute JavaScript, but it does **not** stop a headless browser or a
determined attacker — those can run JS and pass right through. And because it
requires JavaScript, it can affect legitimate clients that have JS disabled, which
has accessibility implications. Treat BotBuster as one layer and pair it with
rate-limiting or a CAPTCHA where you need stronger protection.

> **Note on version.** This module is at `1.0.0-alpha3` — an alpha release. Test
> it carefully before relying on it in production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose the protected paths and set
   up the challenge.

## Where it lives in the admin menu

BotBuster adds a settings form under **Configuration** (the `botbuster.settings`
route), where you configure the protected paths and the challenge. See
[Configuration](configuration/index.md).

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Open the settings form and list the paths that should be protected — start with
   abuse-prone ones such as forms or expensive endpoints.
3. Test as a normal visitor with JavaScript on (you should pass) and consider how
   no-JS clients are affected.
4. Layer it with rate-limiting or CAPTCHA where the risk is higher.
