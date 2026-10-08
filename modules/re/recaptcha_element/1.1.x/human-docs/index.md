# ReCaptcha Element — manual setup guide

**ReCaptcha Element** (`recaptcha_element`) adds Google **reCAPTCHA v3** protection
to your forms. Unlike the old checkbox or image-puzzle challenges, reCAPTCHA v3 is
**invisible and score-based**: it runs quietly in the background, gives each
submission a score from 0.0 (almost certainly a bot) to 1.0 (almost certainly human),
and lets you reject anything below a threshold you choose — all without interrupting
legitimate users.

It gives you two ways to use it. First, a reusable form element (`recaptcha_element`)
that a developer can drop into any custom form with a single `#type`. Second, a
**Webform handler**, so a site builder can protect any webform (contact form,
registration, newsletter signup, lead capture) just by adding a handler — no code.
Behind the scenes, the module's JavaScript fetches a reCAPTCHA token on submit and
the server verifies it with Google using the official `google/recaptcha` PHP library,
checking the score, the action name, and optionally the hostname.

A single settings page holds your site key and secret key, a global on/off switch (so
you can disable reCAPTCHA entirely on dev and staging), the default action and score
threshold, and a logging toggle for tuning. Individual forms and webforms can
override those defaults, so you can run a strict threshold on high-value forms and a
looser one elsewhere.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it needs the
   `google/recaptcha` library) and enable the module.
2. [Configuration](configuration/index.md) — enter your reCAPTCHA v3 keys, set the
   defaults, and attach protection to a form or webform.

## Where it lives in the admin menu

The settings form is at **Configuration → Web services → ReCaptcha Element**
(`/admin/config/services/recaptcha_element`), gated by the single **Administer
recaptcha_element** permission. Webform protection is added on each webform's
**Settings → Handlers** tab.

## How to use it

First register a reCAPTCHA **v3** key pair with Google and enter the site key and
secret key on the settings page. Then attach protection where you need it: add the
**reCAPTCHA Element** handler to a webform, or (for developers) add a
`#type => 'recaptcha_element'` element to a custom form. The full walkthrough is in
[Configuration](configuration/index.md).
