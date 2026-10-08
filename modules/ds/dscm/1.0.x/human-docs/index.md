# Did Someone Clone Me — manual setup guide

**Did Someone Clone Me** (`dscm`; the internal machine name is
`didsomeonecloneme`) is a brand‑protection aid against **phishing clones** of
your site. It embeds a small **beacon link** into your page source. If someone
copies your pages onto another host, the beacon still points back to your
canonical site — so when the cloned copy loads in a victim's browser, its
presence on the wrong host reveals that a foreign copy exists, and the site owner
can be notified.

The workflow pairs the module with the external service at
[didsomeoneclone.me](https://didsomeoneclone.me): you generate a personal beacon
link there, then paste it into this module's settings form. When a clone is
detected, the service emails the site owner. All information about the service
lives on that site.

Set expectations honestly: detection is **heuristic**. It depends on the clone
preserving your embedded markup, and a determined attacker can strip the beacon
before republishing. Treat it as an **early‑warning aid**, not a guarantee, and
pair it with monitoring and a takedown procedure so a detected clone actually
leads to action. The module only *adds output and an admin form* — it exposes no
inbound endpoints that accept anonymous changes, adds negligible page weight, and
needs no cron, queue, or (on the Drupal side) external API. Consider your Content
Security Policy and any privacy/legal implications of the beacon's callback.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — generate a beacon link and paste it
   into the settings form.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Did Someone Clone Me**
(`/admin/config/system/did-someone-clone-me`, route
`didsomeonecloneme.settings`). It is gated by the dedicated **administer
didsomeonecloneme settings** permission.
