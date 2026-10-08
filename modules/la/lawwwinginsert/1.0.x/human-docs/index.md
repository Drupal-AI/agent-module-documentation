# Lawwwing (script insert) — manual setup guide

**Lawwwing** (project `lawwwinginsert`, module machine name `lawwwing`) is a small
module that injects the Lawwwing cookie‑consent widget script into the `<head>` of
your pages. You enter a Lawwwing Script ID, and the module attaches Lawwwing's
`cookie-widget.min.js` from Lawwwing's CDN to every page — with two refinements:
you can choose whether to include it on admin pages, and you can limit it to
specific user roles.

> **Heads‑up on which module to use.** This project was created *before* the
> official Lawwwing Drupal module existed. Its own maintainers recommend using the
> **official [`lawwwing`](https://www.drupal.org/project/lawwwing) module**
> instead, which is actively maintained and supported by the Lawwwing team. Reach
> for this one only if you specifically need its lightweight, script‑only
> approach.

Compared with the official CMP module, this one is intentionally minimal: it makes
**no server‑side external calls** — the consent widget is a client‑side script
loaded from `cdn.lawwwing.com`. It does nothing until you set a Script ID, and its
single admin route is permission‑gated. This module is **not covered by Drupal's
security advisory policy**.

Because it embeds a third‑party script, the usual consent‑embed considerations
apply: the CDN domain must be allowed by your Content‑Security‑Policy, and (because
of the role filter) anonymous visitors only get the banner if you explicitly
select the *anonymous* role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (note the machine name is `lawwwing`).
2. [Configuration](configuration/index.md) — enter your Script ID and choose where
   and to whom the widget loads.

## Where it lives in the admin menu

The settings form is at **Configuration → Web services → Lawwwing Settings**
(`/admin/config/lawwwing`), gated by the *administer lawwwing settings*
permission. See [Configuration](configuration/index.md).
