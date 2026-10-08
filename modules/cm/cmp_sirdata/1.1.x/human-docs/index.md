# Sirdata CMP — manual setup guide

**Sirdata CMP** (`cmp_sirdata`) integrates the
[Sirdata](https://www.sirdata.com/) Consent Management Platform into your Drupal
site — the cookie/consent banner visitors see, built to help you respond to privacy
regulations such as GDPR, ePrivacy and CCPA. Sirdata's CMP is certified against the
IAB Transparency & Consent Framework (v2.1), so it plays nicely with programmatic
advertising and eCommerce partners.

The appeal is that it's a **turnkey integration**: you don't touch any source code.
You set up your CMP in your Sirdata account (or use a pre‑configured one), then paste
two identifiers — your **Customer Key** and **App Key** (Sirdata's project page calls
these your "partner" and "config" IDs) — into this module's settings form, tick
**Enable**, and the banner appears on your site's front end. Sirdata handles the rest, including 16
languages (auto‑detected from the browser), design personalization, Google AMP
compatibility, and the TCF consent signal that partners read.

Under the hood, the module **loads Sirdata's third‑party CMP script**. That script
manages consent, may itself set cookies, and communicates with Sirdata. Consent
decisions collected by the CMP are meant to govern whether your other tracking runs —
so you'll want to **wire your analytics and marketing tags to respect the CMP's
consent signal** (Sirdata's tag‑conditioning tooling helps with this). The module
provides its own permission for administering the configuration and has no content
role beyond that.

One honest caveat, straight from the module authors: installing this module lets you
display the Sirdata CMP, but a CMP is only one part of a compliance process — using
it does not by itself guarantee compliance with any privacy law.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — paste your Sirdata partner and config
   IDs and connect your tags to the consent signal.

## Where it lives in the admin menu

After enabling, open the Sirdata CMP settings form (under **Configuration → System**)
to enter your Customer Key and App Key. Administering it is controlled by the module's
own restricted permission.
