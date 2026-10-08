# MTCaptcha Module — manual setup guide

**MTCaptcha Module** (`mtcaptcha`) integrates the **MTCaptcha** service into your
Drupal forms to keep spam bots and brute‑force attempts out. MTCaptcha is a
privacy‑oriented, GDPR‑friendly alternative to Google reCAPTCHA: it presents a
challenge that a visitor must pass before a protected form will submit, and it
supports accessibility and localization for 60+ languages.

Once you have entered your MTCaptcha **site key** and **private key** (obtained by
registering your domain with MTCaptcha), the module can add the challenge widget to
the forms you choose — commonly the login, registration, password‑reset, contact,
and comment forms, plus any other form you want to protect. The site key is public
(it is rendered into the page), while the private key is used **server‑side** to
verify each challenge response with MTCaptcha's API, so it must be kept secret.

The module ships several ready‑made **skins/themes** (Standard, Overcast,
Neowhite, Blackmoon, Darkruby, Chrome, Highcontrast, and more) so the widget can
match your site. It requires **PHP 8.3** and loads its widget through defined
JavaScript libraries. It provides permissions to administer its settings (and to
exempt trusted roles from being challenged). It also expects the core‑contrib
**CAPTCHA** module to be present, which is the standard framework for attaching
challenges to Drupal forms.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, add the CAPTCHA
   module, and enable it.
2. [Configuration](configuration/index.md) — enter your MTCaptcha keys (storing the
   private key as a secret) and choose which forms are protected.

## Where it lives in the admin menu

The settings form is at `mtcaptcha.settings` — under **Configuration**, reachable
via the module's *Configure* link on the Extend page. You will also use
**People → Permissions** to grant the administer/exempt permissions the module
provides.
