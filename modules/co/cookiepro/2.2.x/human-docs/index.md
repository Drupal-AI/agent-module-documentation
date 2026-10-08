# CookiePro by OneTrust — manual setup guide

**CookiePro by OneTrust** (`cookiepro`) is a thin bridge between your Drupal site
and the [OneTrust / CookiePro](https://www.cookiepro.com/) cookie-consent service.
It gives you a place to paste the script tag OneTrust provides and then renders
that script into the `<head>` of every page — so the cookie-consent banner and
preference center appear across your site to help you meet GDPR, CCPA, and
ePrivacy requirements.

It's important to be clear about the division of labor. **All of the actual
consent logic lives in OneTrust's external service, not in this module.** The
cookie scanning, the banner design, the preference center, the "Do Not Sell"
handling, the autoblocking of third-party trackers — those are OneTrust features
that require a CookiePro/OneTrust account. This module's entire job is to deliver
their script reliably into your page head so it runs before your other trackers
fire. There is no field, no block, and no Drush command; it is purely a
head-script injector aimed at the cookie-consent use case.

Practically, using it is a one-field affair. You get a script tag from your
CookiePro account (typically the autoblocking "Main Cookies Script Tag", plus
optional "Cookie Settings" and "Cookie List" snippets), paste it into the
module's single **Scripts** setting, and save. From then on the module emits that
markup into `<head>` on every request, rebuilding the tags from your saved
configuration each time. Because the value is stored in one configuration object,
you can export it and deploy the same consent setup across environments — just
remember to swap the domain-script id when moving from a test data domain to
production.

Access to the settings form is controlled by the module's own permission, so you
can limit who is allowed to change the consent script.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the single Scripts settings field,
   what to paste, and how the permission works.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → Development → CookiePro
by OneTrust** (`/admin/config/development/cookiepro`). Access to it is gated by the
**CookiePro by OneTrust** permission (`cookiepro_settings`), granted under
**People → Permissions**.

## How to use it

1. Sign in to your CookiePro/OneTrust account and copy your **Main Cookies Script
   Tag** (and any optional Cookie Settings / Cookie List snippets).
2. In Drupal, go to **Configuration → Development → CookiePro by OneTrust**.
3. Paste the script(s) into the **Scripts** field and **Save configuration**.

The consent banner is emitted on every page from that point on. See
[Configuration](configuration/index.md) for the details of exactly what to paste
and how the injection behaves.
