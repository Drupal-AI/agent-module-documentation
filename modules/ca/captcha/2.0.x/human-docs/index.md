# CAPTCHA — manual setup guide

**CAPTCHA** (`captcha`) adds a challenge — a small test a human can pass but an
automated script usually cannot — to virtually any Drupal form. Its job is to block
spam and automated submissions: fake account registrations, credential‑stuffing
login attempts, comment and contact‑form spam, and so on. Out of the box the module
ships a simple **Math** challenge ("solve 3 + 4"), and the bundled **Image CAPTCHA**
submodule adds a distorted‑text image challenge. Trusted users can be exempted, so
the challenge only ever gets in the way of untrusted, likely‑automated traffic.

You decide *which* forms are protected by creating **CAPTCHA points** — each one maps
a form (by its form ID, e.g. `user_login_form`) to a challenge type — or you switch
on a single setting to protect every form at once. If you want the well‑known
Google reCAPTCHA "I'm not a robot" widget instead, that lives in a **separate**
[`recaptcha`](https://www.drupal.org/project/recaptcha) module that plugs into this
same CAPTCHA API; it is not part of this project.

This guide is written for a **human** clicking through the admin UI. It walks you,
step by step and with screenshots, from installing the module to protecting a
specific form. If you are looking for terse, token‑cheap references for an AI coding
agent, read the sibling [`agent/`](../agent/start.md) docs instead.

![The CAPTCHA settings page under Configuration → People](images/settings.png)

## Contents

1. [Installation](installation/index.md) — install the module, enable it, and add the
   Image CAPTCHA submodule if you want an image challenge.
2. [Configuration](configuration/index.md) — set the default challenge type,
   persistence, whitelisted IPs, and the challenge wording on the CAPTCHA settings
   page.
3. [Protecting a form](protecting-a-form/index.md) — attach a challenge to a specific
   form using CAPTCHA points.

## Where it lives in the admin menu

Everything in this guide sits under **Configuration → People → CAPTCHA module
settings** (`/admin/config/people/captcha`). That page carries the tabs you will use:

- **CAPTCHA Settings** — the global settings form (`/admin/config/people/captcha`).
- **Captcha Points** — the list of forms that have a challenge
  (`/admin/config/people/captcha/captcha-points`).

Two permissions govern the module: **administer CAPTCHA settings** (needed to reach
any of these screens) and **skip CAPTCHA** (users who have it are never challenged —
grant it to site administrators and other trusted roles).
