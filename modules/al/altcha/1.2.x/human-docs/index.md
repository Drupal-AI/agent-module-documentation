# ALTCHA — manual setup guide

**ALTCHA** (`altcha`) is a free, open‑source, privacy‑friendly alternative to
image‑puzzle CAPTCHAs. Instead of asking visitors to click traffic lights or
decipher warped text, it protects your forms with a **proof‑of‑work** challenge:
the visitor's browser quietly solves a small computation, and a checkbox confirms
it. No third‑party tracking, no GPU farm, and it can run entirely self‑hosted, so
no user data leaves your site — which makes it a GDPR‑safe, accessible choice for
registration, login, contact, comment, and webform pages.

ALTCHA plugs into the contrib **CAPTCHA** module: it registers a challenge type
called "ALTCHA" that you attach to any form through CAPTCHA's normal per‑form
placement (at *Configuration → People → CAPTCHA*). When the form is submitted, the
module verifies the proof‑of‑work payload. It supports three integration modes: the
default **self‑hosted** mode (Drupal generates and signs challenges locally with an
HMAC secret key, created automatically on install), and two hosted modes,
**Sentinel API** and **SaaS API**, which call an external ALTCHA service with an API
key and can optionally fall back to self‑hosted verification.

From its settings form you can tune the proof‑of‑work complexity, challenge expiry
and delay, an invisible/floating widget mode, auto‑verification behaviour, logo and
footer hiding, JavaScript library overrides, and full per‑language label overrides.
An optional submodule, **altcha_obfuscate**, hides email/phone/text field values
behind the same proof‑of‑work until a visitor chooses to reveal them.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module
   and the CAPTCHA dependency.
2. [Configuration](configuration/index.md) — the settings form and placing ALTCHA
   on your forms.

## Where it lives in the admin menu

The ALTCHA settings form is a tab under the CAPTCHA settings, at **Configuration →
People → CAPTCHA → ALTCHA** (`/admin/config/people/captcha/altcha`), and requires
the **Administer ALTCHA** permission. You place the challenge on specific forms from
the main CAPTCHA page at **Configuration → People → CAPTCHA**
(`/admin/config/people/captcha`).

## How to use it

Enable ALTCHA and the CAPTCHA module, review the ALTCHA settings (the self‑hosted
defaults work out of the box thanks to the auto‑generated secret key), then go to
the CAPTCHA administration page and add an ALTCHA challenge to each form you want to
protect — the user login, registration, and contact forms are common starting
points.
