# Cookie Consent Notice by CookieYes — manual setup guide

**Cookie Consent Notice by CookieYes** (`cookie_consent_notice_by_cookieyes`)
adds the third‑party **CookieYes** consent‑management script to every front‑end
page of your site, straight from a Drupal admin form. That means you can put a
GDPR/CCPA cookie banner on your site without editing your theme or
`html.html.twig` — you just paste a snippet and tick a box.

The module itself is only a thin script‑injector: the actual banner, cookie
scanning/blocking, and consent logging are all done by CookieYes' hosted service.
So to use it you need a **CookieYes account** (an external SaaS) to get your script
snippet. Once pasted in and enabled, the module loads that script on non‑admin
pages only, and CookieYes takes over from there.

Typical uses are adding a compliant cookie banner with minimal code footprint,
managing the consent snippet centrally in Drupal config (so it can be exported
between environments), toggling the banner on and off with one checkbox, and giving
each site in a multisite its own CookieYes account.

> **Heads‑up — known issues in the 3.0.x release.** This version ships with two
> defects worth knowing about before you rely on the admin form:
>
> 1. The settings form's route points at a form class that doesn't exist, so the
>    settings **page errors** until patched. As a workaround you can set the values
>    with Drush (see [Configuration](configuration/index.md)).
> 2. The bundled default‑config file is missing its `.yml` extension, so no default
>    configuration is written on install — the config simply starts empty, which is
>    harmless (nothing is injected until you set the values).
>
> These are documented in the sibling [`agent/`](../agent/start.md) docs.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — pasting your CookieYes snippet and
   enabling it (including the Drush workaround for the form defect).

## Where it lives in the admin menu

Once enabled, the settings form is at **Configuration → Development → Cookie
Consent Notice by CookieYes**
(`/admin/config/development/cookie_consent_notice_by_cookieyes`). Reaching it
requires the restricted **`cookieyes_scripts_settings`** permission.

## How to use it

1. Create a CookieYes account and copy the `<script>` snippet it gives you.
2. Enable the module and grant the `cookieyes_scripts_settings` permission to the
   role that will manage it.
3. Paste the snippet into the module's settings and turn on **Enable** — see
   [Configuration](configuration/index.md). The CookieYes banner then appears on
   your front‑end pages.
