# GTM (Google Tag Manager) — manual setup guide

**GTM** (`gtm`) adds a Google Tag Manager container to your Drupal site. Google Tag
Manager is a hosted tool for managing analytics and marketing tags (Google
Analytics / GA4, Google Ads, tracking pixels, consent tools, session recorders,
and so on) from one place, without editing your site's code every time a tag
changes. This module injects the standard GTM container snippet — both the `gtm.js`
head script and the `<noscript>` iframe fallback — into every page, so all your
tag management then happens in the Google Tag Manager web UI.

The module does exactly one job and does it simply. You enter your container ID
(the `GTM-XXXX` string from your Google Tag Manager account) on a small settings
form, flip the master **Enable** switch, and the snippet is added to your pages.
Everything after that — which tags fire, on what triggers, with what variables — is
configured on Google's side, not in Drupal.

There is nothing to see until you configure it: enabling the module alone injects
nothing, because both the container ID and the Enable switch must be set first. It
has **no dependencies** beyond Drupal core and works on Drupal 8, 9, 10, or 11. It
provides no submodules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — the exact config keys, the
insertion conditions, and the drush recipe — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enter your container ID, enable
   injection, and control where the snippet fires.

## Where it lives in the admin menu

The settings form sits at **Configuration → System → Google Tag Manager**
(`/admin/config/system/gtm`). Access is gated by the **Administer GTM** permission.

## How to use it

Set up your container in your Google Tag Manager account first and copy its
container ID. Then, on the Drupal settings form, paste the ID, tick **Enable**, and
choose whether the snippet should also load on admin pages and whether to exclude
the superuser from tracking. Save, and the container is live on your front-end
pages. See [Configuration](configuration/index.md) for the details. All tags,
triggers, and variables are then managed in the Google Tag Manager web interface —
you can deploy tracking changes there without a Drupal code deployment.
