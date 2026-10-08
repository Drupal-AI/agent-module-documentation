# External reset password — manual setup guide

**External reset password** (`external_reset_password`) lets you send users
somewhere other than Drupal's built-in password-reset form when they need to
recover their account. You configure an external URL, and from then on the
password-reset action points there — to your identity provider, your single
sign-on portal, or a custom reset page — instead of Drupal's own flow.

This matters on sites where authentication and password management don't live in
Drupal at all. If your users' credentials are owned by an external system, sending
them to Drupal's reset form is confusing at best and broken at worst; this module
routes them to the place that can actually reset their password.

Setup is deliberately small: install the module, enter the external URL on its
settings page, and clear the cache. Because the module changes *where* a sensitive
action (password recovery) happens, the one thing that really matters is that the
URL you point to is trusted and served over HTTPS.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the external reset URL.

## Where it lives in the admin menu

The settings page is under **Configuration → People → External Reset Password**
(`/admin/config/people`). That's where you enter the external URL that resets
should point to.
