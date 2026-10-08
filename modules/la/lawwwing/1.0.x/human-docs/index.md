# Lawwwing — manual setup guide

**Lawwwing** (`lawwwing`) is the official integration for the
[Lawwwing](https://lawwwing.com) **Consent Management Platform (CMP)**. Enabling
it and entering your Lawwwing Plugin ID loads Lawwwing's cookie‑consent widget on
your site, so visitors see a compliant, customizable cookie banner and their
consent is recorded — supporting Google Consent Mode v2, IAB TCF v2.2, Microsoft
UET, and Meta Consent Mode. Lawwwing can also generate and keep legal documents
(privacy policy, cookie policy, terms) up to date, and periodically scan the site
for new cookies and scripts, aiming at multi‑region compliance (GDPR, ePrivacy,
CCPA/CPRA, LGPD, and more).

The banner, the consent records, and the legal documents are all managed by the
**Lawwwing service** through your Lawwwing account — the Drupal module's job is to
connect your site to that account and inject the widget. Most of the styling and
behaviour tuning happens in the Lawwwing dashboard rather than in Drupal.

Because this loads a **third‑party script and sends consent data to Lawwwing**,
treat it as you would any external consent provider: the module needs a valid
Lawwwing account and API key, and your Drupal installation needs **outbound
internet access** to fetch configuration and updates from Lawwwing. The consent
widget is client‑side, so if you run a Content‑Security‑Policy you will need to
allow Lawwwing's script domain. This module is **not covered by Drupal's security
advisory policy**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enter your Lawwwing Plugin ID and
   connect the account.

## Where it lives in the admin menu

After enabling, the module's settings live in the **Configuration** area under
**Lawwwing Settings**, where you enter the Plugin ID from your Lawwwing account.
See [Configuration](configuration/index.md).
