# Cinatra — manual setup guide

**Cinatra** (`cinatra`) puts the **Cinatra AI assistant** right inside your Drupal
editing experience. It adds an assistant panel to node pages, node edit forms, and
the front page, so content editors can draft, expand, shorten, retitle, rewrite,
and improve content — and ask questions — in a chat panel next to what they're
working on, without leaving the page. Because the assistant knows the page you're
on, its suggestions fit the content you're actually editing, and when your Cinatra
instance supports it, an accepted suggestion can be dropped straight back into the
form instead of copied by hand.

The assistant talks to **your own Cinatra instance** — the address you enter in the
settings. Cinatra is an open-source AI platform you or your organisation host (see
[cinatra.ai](https://www.cinatra.ai)); this module is not tied to a fixed outside
service. Because it runs through your instance, the assistant can draw on the tools,
data, and knowledge you've connected there. You need access to a running Cinatra
instance for the panel to work; against an older instance the panel shows a short
"update Cinatra" notice instead.

Connecting is designed to be a **single "Connect with Cinatra" button**: you enter
your instance address, approve the connection on the screen that appears, and the
integration credential is provisioned and stored **server-side automatically** —
you never copy or paste a key. (A pasted connection-string / manual path is still
available for setups without a browser redirect.) The module is careful with that
credential: the long-lived key stays on the server and is never exposed to browser
JavaScript, the connect callback is protected by a single-use, user-bound `state`
plus PKCE, and the server-to-server calls run through an SSRF guard that blocks
loopback, private, link-local, and metadata addresses.

The assistant is shown only to users you choose, via a dedicated **"Use the Cinatra
AI assistant"** permission — not to every logged-in user. Grant it to editors you
trust, since the assistant can read the current page and suggest edits. Be aware
that when an editor chats, the messages they type and the page they're on are sent
to the Cinatra instance you configured (and nowhere else); that instance's own
privacy terms govern that data.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — connect to your Cinatra instance and
   grant the assistant permission.

## Where it lives in the admin menu

Cinatra's settings form sits at **Configuration → Web services → Cinatra**
(`/admin/config/services/cinatra`). The assistant permission is granted at
**People → Permissions** (`/admin/people/permissions`).
