# Plausible tracking — manual setup guide

**Plausible tracking** (`plausible_tracking`) integrates
[Plausible Analytics](https://plausible.io/) into your Drupal site. Plausible is a
simple, open-source, lightweight, and privacy-friendly alternative to Google
Analytics — it is **cookieless** and does not collect personal data — so it is a
popular choice for sites that want meaningful traffic numbers without the compliance
weight of cookie-based analytics.

The module adds Plausible's tracking script to your pages and gives you control over
what gets measured. Beyond basic page views it can track **custom events**, **outbound
link clicks**, **file downloads**, and **custom query parameters as pageview events**,
and it can **exclude specific IP addresses** from tracking (handy for keeping your own
team's visits out of the numbers).

A note on privacy: Plausible is designed to be **cookieless and GDPR-friendly**, which
generally lowers the consent burden compared with cookie-based analytics. That is a
real advantage, but it is not a blanket exemption — you should still confirm your own
compliance position and **disclose your use of analytics in your privacy policy**. The
module loads Plausible's third-party script, so that external request is worth noting.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set your domain and tracking host, and
   turn on the optional tracking features.

## Where it lives in the admin menu

The settings form is at `plausible_tracking.settings` — look for **Plausible tracking**
under the site **Configuration** section. You need the appropriate permission (the
module provides its own) to administer it. See
[Configuration](configuration/index.md) for the fields.
