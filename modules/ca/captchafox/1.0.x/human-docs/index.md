# CaptchaFox — manual setup guide

**CaptchaFox** (`captchafox`) adds the privacy-focused **CaptchaFox** service as a
challenge provider for Drupal's **CAPTCHA** module. Once configured, you can present
a CaptchaFox challenge on your forms to deter spam and bots while letting real
people through — a GDPR-friendly alternative to providers that send visitor data to
large ad networks. It integrates directly with the CAPTCHA module, so you assign it
to forms the same way you would any other CAPTCHA type.

It is implemented correctly on the point that matters most for this kind of service:
the challenge is verified **server-side**. When a form is submitted, Drupal sends the
visitor's CaptchaFox response together with your **secret key** to
`https://api.captchafox.com/siteverify` over HTTPS, and only accepts the form when
CaptchaFox confirms success — the browser cannot simply claim to have passed.

Two security essentials follow from that. First, your CaptchaFox **secret key is a
credential** and must be stored as one — never commit it or paste it into exported
configuration; keep it distinct from the public site key. Second, make sure the
verification step **fails closed** (rejects the submission) if the CaptchaFox service
is unreachable, so an outage can't be used to slip past the challenge.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside the CAPTCHA module.
2. [Configuration](configuration/index.md) — enter your CaptchaFox site and secret
   keys, then assign the challenge to forms.

## Where it lives in the admin menu

After you enable it, a **CaptchaFox** tab appears on the CAPTCHA administration page
at `/admin/config/people/captcha/captchafox`, where you enter your keys. You then
choose which forms show the CaptchaFox challenge from the main CAPTCHA administration
page (`/admin/config/people/captcha`).
