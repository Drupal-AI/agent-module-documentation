# CaptchEtat — manual setup guide

**CaptchEtat** (`captchetat`) integrates the **CaptchEtat** CAPTCHA service — a
CAPTCHA operated for French government (service-public) sites through Piste Gouv —
into Drupal via the **CAPTCHA** module. It presents a distorted CAPTCHA string that
the user copies, giving forms protected by CAPTCHA a French public-sector challenge
as an alternative to reCAPTCHA. This 2.x release integrates with the CAPTCHA module
(the older 1.x line integrated with Webform instead), so you assign the challenge to
forms from CAPTCHA's *CAPTCHA points* configuration.

Setup is straightforward once you have credentials: enable the module, enter your
authentication keys, and assign the challenge to the forms that need protection.
Because it is an externally hosted CAPTCHA, every challenge is issued and verified by
the CaptchEtat service, so its availability affects your forms, and the API keys it
uses must be treated as secrets.

A note on prerequisites: as with any French government CAPTCHA integration, make sure
you meet the legal requirements and obtain the necessary authorization from the
relevant authorities before going live. You obtain a **secret key** and a **client
key** from Piste Gouv to authenticate the integration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside the CAPTCHA module.
2. [Configuration](configuration/index.md) — enter your CaptchEtat credentials and
   assign the challenge to forms.

## Where it lives in the admin menu

The module's settings form is at route `captchetat.settings`, where you enter the
API endpoint and your Piste Gouv authentication keys. After configuring it there, you
assign the CaptchEtat challenge to specific forms from the CAPTCHA module's
administration pages.
