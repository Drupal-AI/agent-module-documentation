# Forgot Username — manual setup guide

**Forgot Username** (`forgot_username`) adds a public **"forgot username" form**
for logged‑out visitors at `/user/username`. A visitor enters the email address on
their account and the module emails them their Drupal username. It's a natural
companion to Drupal's built‑in password reset — helping people who remember their
email but have forgotten which username to sign in with.

Setup is minimal: install the module and the form is available at `/user/username`
for anonymous users. There is no settings form to configure.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module. Its behaviour is described in
"How to use it" below.

## Where it lives in the admin menu

The module adds no admin settings page. Its user‑facing form lives at
**`/user/username`** for logged‑out visitors.

## How to use it

1. Enable the module (see Installation).
2. Point users who have forgotten their username to **`/user/username`** — for
   example, add a link next to your login and password‑reset links.
3. A visitor enters their account email; the module emails them their username.
