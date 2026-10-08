# Cookie Information — manual setup guide

**Cookie Information** (`cookieinformation`) connects your Drupal site to the
third-party **Cookie Information** (cookieinformation.com) consent platform. Once
configured, it injects that platform's cookie-consent popup on every page — with the
right language chosen automatically — and can optionally enable Google Consent Mode
(v1 or v2), IAB TCF for ad-tech vendors, and client-side blocking of third-party
iframes (YouTube, Vimeo, maps) until the visitor gives consent. It's a compliance
tool: a way to meet GDPR/ePrivacy cookie-consent requirements without hand-coding the
vendor's snippet into a template.

The most important thing to know up front: **this module requires an active Cookie
Information account.** It is an integration layer, not a standalone consent manager.
The actual consent banner design, the cookie declaration table, and the templates all
live on the Cookie Information platform (go.cookieinformation.com), where you need a
subscription and a configured template — especially for the IAB and Google Consent
Mode v2 features. The module itself ships no secret and only injects fixed vendor
script URLs. It depends on core **Path alias**.

It provides one settings form and two optional blocks — a **Cookie Policy** block
(renders the platform's cookie-declaration table, for a policy page) and a **Privacy
Controls** block (lets visitors reopen and change their consent choices). Two
permissions gate it, and the popup can be hidden on admin pages, for the superuser,
and on paths you exclude.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form field by field, the
   two blocks, and the visibility/exclusion options.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Cookie Information**
(`/admin/config/system/cookie-information`), behind the **Administer cookie
information settings** permission. The two blocks are placed at **Structure → Block
layout** under the "Cookieinformation" category.

## How to use it

Set up a template on your Cookie Information account, enter the settings on the Drupal
form (turn the popup on, pick your Google Consent Mode / IAB / iframe-blocking
options), and place the Cookie Policy and Privacy Controls blocks where you want them.
See [Configuration](configuration/index.md) for the full walkthrough.
