# Iubenda Integration — manual setup guide

**Iubenda Integration** (`iubenda_integration`) connects your Drupal site to the
third-party **Iubenda** privacy and compliance service. Iubenda hosts your privacy
policy, cookie-consent banner, and consent records; this module wires those into
Drupal so you can render the privacy-policy link, inject the cookie-consent banner,
and enable Iubenda's Consent Solution — all from Drupal admin forms.

You supply the codes and IDs that Iubenda generates in your Iubenda dashboard (a
privacy-policy code, a cookie-solution site ID, and a consent-solution API key). The
module then loads Iubenda's JavaScript on your front-end pages, shows the
cookie-consent banner, and can lock third-party scripts until the visitor consents.
It can also add a required "I have read the Privacy Policy" checkbox to specific
Drupal forms (by form ID), so submissions are gated on consent.

Beyond the banner, the module gives you a **block** that outputs the Iubenda
privacy-policy link, a **`[site:iubenda_integration]` token** you can drop into any
token-enabled text, and support for several legal frameworks (GDPR, LGPD, FADP, and
US-state laws) from a single site ID. Iubenda's scripts load from `cdn.iubenda.com`,
and only on non-admin pages, and only once you have set a privacy-policy code.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant the permission.
2. [Configuration](configuration/index.md) — the three settings forms (General /
   Privacy, Cookie Solution, Consent Solution), the block, and the token.

## Where it lives in the admin menu

The settings live under **Configuration → Services → Iubenda Integration**
(`/admin/config/services/iubenda-integration`), split across three tabs: **General /
Privacy**, **Cookie solution**, and **Consent solution**. All three are gated by the
single **Administer iubenda_integration** permission.

## How to use it

1. In your Iubenda dashboard, generate the codes you need (privacy-policy code,
   cookie-solution site ID, and — if you use it — a consent-solution API key).
2. Enter them on the [Configuration](configuration/index.md) forms in Drupal.
3. Optionally place the **Iubenda Integration: Privacy policy** block in a region,
   or embed the `[site:iubenda_integration]` token in your footer or a text field.
4. Optionally list the Drupal form IDs that should show a required privacy-consent
   checkbox.
