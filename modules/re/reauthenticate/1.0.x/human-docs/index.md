# Reauthenticate — manual setup guide

**Reauthenticate** (`reauthenticate`) adds a layer of "prove it's still you"
security to the pages you choose. Even when a user is already logged in, if they
navigate to a page you've marked as sensitive, Reauthenticate forces them to
re‑enter their password before they can continue. This is often called **step‑up
authentication**.

The value is straightforward: sessions linger. Someone logs in, walks away from an
unlocked laptop, or has their session hijacked — and their high‑risk pages (editing
their account, managing a webform, reaching an admin area) are wide open. By
requiring a fresh password entry on exactly those pages, Reauthenticate makes sure
the person acting is the person who owns the account, without forcing a full
re‑login for ordinary browsing.

You decide which pages are protected by listing path patterns — for example
`/user/*/edit*` or `/admin/structure/webform*`. Any page matching a pattern
prompts for the password before it loads.

> This project is a **beta release** (`1.0.0-beta8`) and is **not covered by
> Drupal's security advisory policy**. Test it thoroughly before relying on it in
> production, and treat it as one layer of defense rather than a complete access
> solution.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — list the paths that require
   reauthentication.

## Where it lives in the admin menu

Once enabled, open the module's settings form from the modules list (**Extend**,
then the module's **Configure** link) or from the site's configuration section,
and list the paths you want to protect — see
[Configuration](configuration/index.md).
