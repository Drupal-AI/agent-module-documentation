# Friendly Captcha — manual setup guide

**Friendly Captcha** (`friendlycaptcha`) adds the privacy-friendly Friendly Captcha
service to Drupal as a CAPTCHA challenge type. Instead of asking visitors to solve an
interactive puzzle — clicking traffic lights or reading distorted text — the
visitor's browser silently solves a cryptographic proof-of-work in the background
while the widget runs. Real people pass through without doing anything, while bots
are slowed down. Because it does no user tracking and shows no puzzle, it's a common
privacy- and GDPR-conscious alternative to Google reCAPTCHA.

This is an **add-on for the CAPTCHA module**, not a standalone form element — it
depends on `captcha` and registers itself as a challenge type, so "Friendly Captcha"
appears as an option wherever you configure CAPTCHA points (per form, or as the site
default). The front end uses the `friendly-challenge` JavaScript widget, which you
install into `/libraries/friendly-challenge/`; on submit, the module verifies the
solved token server-side.

There are four ways to verify solutions, chosen on the settings form: the **global**
endpoint (default) and two **EU** endpoints verify against Friendly Captcha's hosted
service using your site key and API key (the EU endpoints need a Business/Enterprise
plan), while the **local** endpoint makes your own Drupal site serve puzzles and
verify them — no account or keys required, and no data leaves your server. If keys
are missing, the module safely falls back to CAPTCHA's Math challenge and warns
administrators. The challenge is cacheable, so it works on cached pages. There are no
submodules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the CAPTCHA
   dependency with Composer, install the JavaScript widget, and enable everything.
2. [Configuration](configuration/index.md) — the settings form (endpoint, keys,
   logging) and how to place the challenge on your forms via CAPTCHA.

## Where it lives in the admin menu

The Friendly Captcha settings form sits at **Configuration → People → CAPTCHA →
Friendly Captcha** (`/admin/config/people/captcha/friendlycaptcha`) — it's a tab
under the CAPTCHA module's settings. Which forms actually use it is decided on the
main CAPTCHA screen at **Configuration → People → CAPTCHA**.

## How to use it

Install and enable both CAPTCHA and Friendly Captcha, drop the `friendly-challenge`
widget into `/libraries`, then either pick "Friendly Captcha" as the default
challenge on the CAPTCHA settings page or add a CAPTCHA point for a specific form.
Enter your site and API keys on the Friendly Captcha settings form (or choose the
local endpoint to run without any account). See [Configuration](configuration/index.md)
for the details.
