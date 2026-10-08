# Simple Google reCaptcha — manual setup guide

**Simple Google reCaptcha** (`simple_recaptcha`) adds Google reCAPTCHA
protection to the Drupal forms you choose — without writing any per‑form code.
You simply list the form IDs you want protected, enter your Google reCAPTCHA
keys, and the module attaches the challenge and verifies it on submit. It keeps
login, registration, contact, comment, and other forms safe from spam bots.

It supports both flavours of reCAPTCHA. **v2** shows the familiar "I'm not a
robot" checkbox; **v3** is invisible and silently scores each request, letting
you set a minimum score to accept. You pick one type globally, store separate
site/secret key pairs for v2 and v3, and can optionally hide the v3 badge (while
still meeting Google's attribution requirement elsewhere). Form matching supports
`*` wildcards, so `contact_message_*` protects every contact form at once, and a
"use globally" switch protects every form on the site.

Two permissions give you control: one gates the settings form, and a **bypass**
permission lets trusted roles skip the challenge entirely — with a developer hook
for per‑form exceptions. A bundled **Webform** submodule adds a handler so you
can turn reCAPTCHA on for individual webforms. You will need reCAPTCHA keys from
Google's admin console for verification to actually work.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and note the Webform submodule.
2. [Configuration](configuration/index.md) — get Google keys, choose v2 or v3,
   and list the forms to protect.

## Where it lives in the admin menu

The settings form sits at **Configuration → Web services → Simple reCAPTCHA**
(`/admin/config/services/simple_recaptcha`). The two permissions are managed at
**People → Permissions**.

## How to use it

First, register your site in Google's reCAPTCHA admin console and copy the site
and secret keys. Then open the settings form, choose **v2** or **v3**, paste the
matching keys, and list the **form IDs** you want protected (or flip the "use
globally" switch). That's it — the listed forms now show the challenge and are
verified server‑side on submit. See [Configuration](configuration/index.md) for
the full walkthrough.
