# Qwebirc IRC — manual setup guide

**Qwebirc IRC** (`qwebirc`) embeds a **qwebirc** web‑based IRC client into your
Drupal site, so community members can join your project's or community's IRC channels
straight from a page — no standalone IRC application required. The qwebirc client is
a polished AJAX widget, and this module makes it easy for administrators to drop that
widget onto the site inside an iframed page.

Once enabled, the client appears on your site at **`/irc`**. (A future goal was to
also offer it as a block, but in this release you reach it by navigating to the
`/irc` page.) The IRC server / qwebirc endpoint the widget connects to is set by an
administrator.

> **Compatibility note:** Qwebirc is based on the older Mibbit module and is **not
> compatible with Mibbit running at the same time** — do not enable both. The module
> describes itself as beta.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

This module has **no dedicated settings page** of its own in the usual Configuration
section; setup is minimal, as described below.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Make sure the Mibbit module is **not** enabled at the same time.
3. Point the client at the IRC server / qwebirc endpoint you want your visitors to
   join (the endpoint is administrator‑configured).
4. Send community members to **`/irc`** on your site, where the embedded IRC widget
   loads inside the page.

Because access to the page and the widget is controlled by the module's own
permission, review **People → Permissions** and grant the "use" permission to the
roles that should be able to open the IRC client.
