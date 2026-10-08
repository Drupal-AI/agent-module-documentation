# CaptchEtat (with CAPTCHA) — manual setup guide

**CaptchEtat (with CAPTCHA)** (`captcha_captchetat`) plugs the French government's
official **CaptchEtat** service into Drupal's **CAPTCHA** module. Once configured,
you can add a CaptchEtat challenge to any form on your site — native Drupal forms,
Webforms, and custom forms — as an alternative to reCAPTCHA and similar providers.

CaptchEtat is developed by the *Agence pour l'Informatique Financière de l'État*
(AIFE). It is a free service dedicated to **French public entities and French State
inter-ministerial partners only**, built to comply with GDPR (as described by the
CNIL) and to follow web-accessibility good practice, including visual *and* audio
rendering of the challenge and French/English multilingual support. For a French
public-sector site the choice matters: unlike reCAPTCHA it does not send visitor
data to Google, and its accessibility support helps avoid excluding disabled users
from your forms.

There is an important prerequisite that is legal, not technical. Before you can use
CaptchEtat you must complete an authorization ("habilitation") process on the
CaptchEtat website appropriate to your organization. Only once approved do you gain
access to the PISTE administration site, where you obtain the `client_id` and
`client_secret` keys the module needs. This 2.x release is built on version 2 of
the CaptchEtat API.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside the CAPTCHA module.
2. [Configuration](configuration/index.md) — enter your CaptchEtat credentials,
   choose the challenge type, and tune flood control.

## Where it lives in the admin menu

The module's settings form lives under the CAPTCHA administration area
(`captcha_captchetat.settings_form`). After you have configured it there, you
assign the CaptchEtat challenge to specific forms from the CAPTCHA module's own
*CAPTCHA points* / administration pages, exactly as you would any other CAPTCHA
type. Administering the integration is gated by the **`administer captcha_captchetat`**
permission — grant it only to trusted administrators.
