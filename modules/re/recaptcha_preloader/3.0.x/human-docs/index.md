# reCAPTCHA Preloader — manual setup guide

**reCAPTCHA Preloader** (`recaptcha_preloader`) smooths out a small but real
annoyance with Google **reCAPTCHA v2 Checkbox** on your forms. On a slow
connection, the reCAPTCHA checkbox can take a moment to appear — and in that gap a
visitor may think the form is fully loaded, click **Submit**, and be confused when
nothing happens because the CAPTCHA element isn't there yet.

This module fixes that with a small bit of UX polish. Alongside the form it shows a
placeholder that looks like the reCAPTCHA box but, instead of a checkbox, carries a
message saying the CAPTCHA is still loading. Meanwhile the form's submit button
starts out **disabled**. As soon as the real reCAPTCHA finishes loading, the
placeholder is swapped for the genuine widget and the submit button becomes
clickable. The result is a form that clearly communicates its state, so nobody
submits too early.

It builds on the standard **CAPTCHA** and **reCAPTCHA** modules — you configure your
reCAPTCHA v2 keys and which forms use a CAPTCHA in those modules as usual, and
reCAPTCHA Preloader simply improves the loading experience on top.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside CAPTCHA and reCAPTCHA.

There is **no dedicated settings page** for this module — it works once enabled,
building on your existing CAPTCHA/reCAPTCHA setup. See "How to use it" below.

## How to use it

1. Make sure the **CAPTCHA** and **reCAPTCHA** modules are installed and
   configured — enter your Google reCAPTCHA **v2 Checkbox** site and secret keys on
   the reCAPTCHA settings page, and set the forms that should use a CAPTCHA
   challenge (under **Configuration → People → CAPTCHA**).
2. Enable reCAPTCHA Preloader ([Installation](installation/index.md)).
3. Visit a form that uses reCAPTCHA v2 Checkbox. While the widget loads you should
   see the placeholder message and a disabled submit button; once it's ready, the
   real checkbox appears and the button becomes clickable.
