# Help Scout Beacon — manual setup guide

**Help Scout Beacon** (`help_scout_beacon`) embeds
[Help Scout's](https://www.helpscout.net) **Beacon** support widget on your Drupal
site. Beacon is the little contact/help button that puts docs search, live chat, and
a "start a conversation" form right on the page, so visitors can get support without
leaving your site. This module wires that widget in: you paste your Beacon's **form
id** on a settings form, and the module loads the Beacon JavaScript and boots it on
the front end.

Two permissions shape who is involved. The settings form is protected by the
**Administer Help Scout Beacon settings** permission, so only trusted
administrators can change the Beacon id. The widget itself is attached only for
users who hold the **Use Help Scout Beacon** permission — so you can show it to,
say, authenticated users or a support role while hiding it from anonymous traffic
(or grant that permission to the anonymous role to show it to everyone).

One reassurance about security: the Beacon **form id is a public, client‑side embed
identifier by design** — it is not a secret, and the module stores no API key or
credential. So there is nothing sensitive to protect here beyond deciding which
roles see the widget.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enter your Beacon form id and grant the
   right permissions.

## Where it lives in the admin menu

The settings form sits at **Configuration → Web services → Help Scout Beacon**
(`/admin/config/services/help-scout-beacon/settings`).

> **A note on the route name:** the module's `.info.yml` "configure" link points at
> `help_scout_beacon.setting`, but the actual settings route is
> `help_scout_beacon.settings`. If the automatic **Configure** link on the Extend
> page does not work, navigate directly to the path above.
