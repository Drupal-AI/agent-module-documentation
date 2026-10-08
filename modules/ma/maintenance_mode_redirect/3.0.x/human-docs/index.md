# Maintenance Mode Redirect — manual setup guide

**Maintenance Mode Redirect** (`maintenance_mode_redirect`) sends visitors to a
URL you choose when your site is in maintenance mode, instead of showing Drupal's
built-in maintenance page. That's useful when you'd rather host your "we'll be
back soon" page somewhere completely independent of Drupal — a static status page
on another host, for instance, that stays up even if the Drupal site is fully
down for a deployment.

It adds two fields to the standard maintenance settings: a checkbox to turn the
redirect on, and a **Redirect URL** for the destination. Visitors who cannot
access the site during maintenance are sent there. You can also define **allowed
paths** (including path-prefix exceptions) that are *not* redirected — which is
important so that you (and any login route) can still reach the site to switch
maintenance mode back off.

The redirect destination is set by an administrator in configuration, not by
anything a visitor supplies, so this is **not** an open-redirect risk — the URL
is always the one you configured.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — enable the redirect, set the
   destination URL, and list any allowed paths.

## Where it lives in the admin menu

The module adds its fields to core's maintenance settings at
**Configuration → Development → Maintenance mode**
(`/admin/config/development/maintenance`).
