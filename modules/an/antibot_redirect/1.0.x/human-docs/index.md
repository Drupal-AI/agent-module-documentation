# AntiBot Redirect — manual setup guide

**AntiBot Redirect** (`antibot_redirect`) protects specific pages from automated
bots by requiring a **reCAPTCHA** challenge before an external redirect happens (or
before a protected page is served). The idea is to stop bots from blindly following
redirects or reaching gated pages: a real person passes the reCAPTCHA and continues,
while automated traffic is stopped, reducing bot abuse.

It builds on Drupal's **reCAPTCHA** module, which is a required dependency and where
your reCAPTCHA site/secret keys are stored securely. Configuration is
administrator‑gated, and the module provides its own permissions. It supports Drupal
10 and 11.

The available documentation for this module is thin on the exact configuration
screens, so this guide describes only what is known for certain: it inserts a
reCAPTCHA gate in front of external redirects / protected pages, and it relies on
the reCAPTCHA module for the challenge itself.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (with reCAPTCHA)
   and enable the module.

## Where it lives in the admin menu

Configuration is administrator‑gated. Because reCAPTCHA handles the challenge, first
set up your keys in the reCAPTCHA module (**Configuration → People → CAPTCHA →
reCAPTCHA**), then use AntiBot Redirect's own admin settings to choose the pages and
redirects it should protect.

## How to use it

1. Install and configure the reCAPTCHA module with your reCAPTCHA keys.
2. Enable AntiBot Redirect (see [Installation](installation/index.md)).
3. Configure which pages / external redirects should require a reCAPTCHA challenge.
4. Grant the module's permissions to the appropriate roles.

Visitors then have to pass a reCAPTCHA before the protected redirect or page
proceeds, which blocks automated bots.
