# Evercurrent — manual setup guide

**Evercurrent** (`evercurrent`) connects your Drupal site to the **Evercurrent**
monitoring service to make managing updates easier — especially when you look after
several sites. Tracking security updates through the regular Drupal update emails gets
cumbersome across many sites; Evercurrent centralizes that. Once connected, you get an
informative email whenever a new security update is available (with current and
recommended versions and past reports), plus a dashboard that lines up every update
needed across all your sites so you can plan them in one go.

The module builds on core's **Update** module: it collects the update/version
information your site reports and sends it to the Evercurrent server, authenticated with
an **API key** you get when you register a site at Evercurrent. As sites report a
successful upgrade, those items drop off the dashboard automatically.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable
   it.
2. [Configuration](configuration/index.md) — enter your Evercurrent API key (and
   endpoint), and keep development environments from reporting.

## Where it lives in the admin menu

After enabling, configure the connection on the module's settings form (reached from
the module's configuration link on **Extend**, or the *Configure* link next to the
module). The module provides its own permission governing who may administer it.

## How to use it

1. Install this module on your **production** site.
2. Log in or create an account at [Evercurrent](https://www.drupal.org/project/evercurrent)
   and create a new site there — you will receive an **API key**.
3. Enter that API key in the module's settings (see
   [Configuration](configuration/index.md)).
4. From then on, your site reports its needed updates to Evercurrent, and you manage
   them from the Evercurrent dashboard and email notifications.

> **What gets sent, and where.** Evercurrent sends your site's update/version
> information — effectively a fingerprint of which modules and versions you run — to the
> external Evercurrent server. Send it only to your trusted Evercurrent endpoint over
> HTTPS, and store the API key securely (see [Configuration](configuration/index.md)).
> Use **one API key per environment**: to stop development or staging environments from
> reporting, set the key only for production (the README describes doing this via
> `settings.php`).
