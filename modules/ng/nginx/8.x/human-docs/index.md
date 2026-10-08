# Nginx — manual setup guide

**Nginx** (`nginx`) is an ops/deployment helper that provides recommended
**Nginx configuration for Drupal**. Rather than adding features inside the Drupal
UI, it ships server and location configuration so a site deployed behind Nginx has
correct, secure defaults for serving Drupal — the kind of rules you would
otherwise copy by hand from a community "Nginx for Drupal" guide. It also
integrates with **Let's Encrypt** (via the `letsencrypt` module) for TLS
certificates.

This is a niche, infrastructure‑focused module: its value is in the configuration
files it provides, not in any admin screen. It has **no configuration page and no
admin menu item**, and enabling it does not change how the site behaves at
runtime. It supports Drupal 8 through 11, and depends on the `letsencrypt` module.

> **Heads up:** this project is at `8.x-dev`, is marked as *seeking a new
> maintainer*, and is **not covered by Drupal's security advisory policy**. Review
> the shipped configuration against your own hosting environment and current Nginx
> best practices before using it in production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Let's Encrypt dependency.

There is **no configuration page** for this module — it provides server‑level
Nginx configuration, not in‑site settings. How to apply it is covered in "How to
use it" below.

## How to use it

The module supplies Nginx configuration intended for your web server, plus
Let's Encrypt integration for certificates. Applying it is a server‑administration
task rather than something done through the Drupal UI:

1. Review the Nginx configuration the module ships and adapt paths, server names,
   and PHP‑FPM settings to your environment.
2. Incorporate that configuration into your Nginx setup (typically by including it
   from your site's server block) and reload Nginx.
3. If you use the **Let's Encrypt** integration, follow the `letsencrypt`
   module's guidance to obtain and renew certificates.

Because this touches your web server directly, test the configuration in a staging
environment first and keep a backup of your working Nginx config.
