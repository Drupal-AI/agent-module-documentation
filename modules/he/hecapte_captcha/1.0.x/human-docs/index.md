# HeCAPTe CAPTCHA — manual setup guide

**HeCAPTe CAPTCHA** (`hecapte_captcha`) adds a **proof-of-work CAPTCHA** to
Drupal's [CAPTCHA](https://www.drupal.org/project/captcha) module. Instead of
asking visitors to tick a box or read a distorted image, HeCAPTe makes the
visitor's browser silently solve an Equihash puzzle in the background using
WebAssembly — no interaction, no tracking, and no third-party SaaS. HeCAPTe is
**self-hosted**: you run your own HeCAPTe server, and this Drupal module connects
your site to it.

The module does three things: it registers a **HeCAPTe challenge type** with the
CAPTCHA module (so you can protect any CAPTCHA-supported form — comments, contact
forms, user registration, Webform, and more); it **proxies the HeCAPTe runtime
assets** (the WebAssembly solver and workers) through Drupal's own routes so the
browser never makes cross-origin requests to your HeCAPTe server; and — most
importantly — it **verifies submissions server-side**.

That server-side verification is the crucial security property, and this module
gets it right: when a form is submitted, Drupal's own validation calls the
HeCAPTe server's `/verify` endpoint and only accepts the submission when the
response status is `ok`. The client cannot self-assert success. Because it depends
on an external HeCAPTe server, make sure verification **fails closed** if that
server is unreachable, set a sensible verify timeout, and always talk to a trusted
HeCAPTe server over HTTPS — covered in [Configuration](configuration/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it alongside the CAPTCHA module, and stand up a HeCAPTe server.
2. [Configuration](configuration/index.md) — entering your server URL and site
   key, choosing which forms to protect, and handling the site key safely.

## Where it lives in the admin menu

The module's own settings form is at **Configuration → People → CAPTCHA →
HeCAPTe** (`/admin/config/people/captcha/hecapte`), where you enter your HeCAPTe
server URL and site key. You then choose HeCAPTe as the challenge type for
specific forms on the main CAPTCHA settings page. See
[Configuration](configuration/index.md).
