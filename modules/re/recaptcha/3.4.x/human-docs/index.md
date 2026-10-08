# reCAPTCHA — manual setup guide

**reCAPTCHA** (`recaptcha`) adds Google's reCAPTCHA (v2) as a challenge type for
the Drupal **CAPTCHA** module, so you can protect forms from spam bots while
letting real people through with a single checkbox — or with an invisible
challenge that never interrupts them. The module does not decide *which* forms
get protected on its own: it registers a "reCAPTCHA" challenge that you assign to
forms through the CAPTCHA module's **CAPTCHA points**. On the server it verifies
the visitor's token against Google's API using the bundled `google/recaptcha` PHP
library.

This guide is written for a **human** clicking through the admin UI. It walks you,
step by step and with screenshots, from installing the module to entering your
Google keys and switching a form's challenge over to reCAPTCHA. Because reCAPTCHA
sits on top of the base **CAPTCHA** module, that module has its own
[human-docs](../../../captcha/2.0.x/human-docs/index.md) covering CAPTCHA points
and global CAPTCHA behaviour — read it alongside this one. If you are looking for
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

![The reCAPTCHA settings form showing the Site key, Secret key and widget options](images/settings.png)

## Where it lives in the admin menu

The reCAPTCHA settings form sits under **Configuration → People → CAPTCHA →
reCAPTCHA** (`/admin/config/people/captcha/recaptcha`). That page is the last of a
row of tabs that belong to the CAPTCHA module:

- **CAPTCHA Settings** (`/admin/config/people/captcha`) — global CAPTCHA behaviour
  and the default challenge type.
- **Captcha Points** (`/admin/config/people/captcha/captcha-points`) — the list of
  forms that get a challenge, and which challenge each one uses.
- **reCAPTCHA** (`/admin/config/people/captcha/recaptcha`) — this module's keys and
  widget options, described in this guide.

## Contents

1. [Installation](installation/index.md) — install reCAPTCHA with Composer, enable
   it along with the CAPTCHA module, and register your site with Google.
2. [Configuration](configuration/index.md) — enter your site and secret keys,
   choose the widget options, and switch a form over to the reCAPTCHA challenge.
