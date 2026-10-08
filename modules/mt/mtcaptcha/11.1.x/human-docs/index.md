# MTCaptcha Module — manual setup guide

**MTCaptcha Module** (`mtcaptcha`) integrates the **MTCaptcha** service into your
Drupal forms to keep spam bots and brute-force attempts out. MTCaptcha is a
privacy-oriented, GDPR-friendly alternative to Google reCAPTCHA: it presents a
challenge that a visitor must pass before a protected form will submit, and it
supports accessibility and localization for 60+ languages.

Once you have entered your MTCaptcha **site key** and **private key** (obtained by
registering your domain with MTCaptcha), the module can add the challenge widget to
the forms you choose — commonly the login, registration, password-reset, contact,
and comment forms, plus any other form you want to protect. The site key is public
(it is sent to the browser so the widget can load), while the private key is used
**server-side** to verify each challenge response with MTCaptcha's API, so it must
be kept secret.

The module ships several ready-made **skins/themes** (Standard, Overcast,
Neowhite, Goldbezel, Blackmoon, Darkruby, Touchoforange, Caribbean, Woodyallen,
Chrome, Highcontrast) and Standard / Modern-Mini widget sizes so the widget can
match your site. It targets **Drupal 10 or 11**, requires **PHP 8.1**, and loads
its widget through defined JavaScript libraries. It provides a permission to
administer its settings. The core-contrib **CAPTCHA** module is recommended for
integration but is not a hard dependency.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, optionally add
   the CAPTCHA module, and enable it.
2. [Configuration](configuration/index.md) — enter your MTCaptcha keys (keeping the
   private key secret) and choose which forms are protected.

## Where it lives in the admin menu

The settings form is at `mtcaptcha.settings` — **Configuration → Development →
MTCaptcha settings** (`/admin/config/development/mtcaptcha`), reachable via the
module's *Configure* link on the Extend page. You will also use **People →
Permissions** to grant the *administer MTCaptcha* permission.
