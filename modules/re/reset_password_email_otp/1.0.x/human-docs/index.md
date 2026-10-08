# Reset Password Email OTP — manual setup guide

**Reset Password Email OTP** (`reset_password_email_otp`) changes how people reset a
forgotten password. Instead of Drupal's default behaviour — emailing a one-time
login *link* — it emails a one-time passcode (OTP) that the user types into a form
to set a new password. The flow for the user is: request a reset and choose to
receive the code by email (or SMS, if configured), retrieve the code, enter it in
the "validate OTP" field, and then set a new password.

The module provides its own settings page and a **block** that renders the reset
form, so you can place the OTP reset flow wherever it fits your site. Email works
out of the box; SMS is optional and requires extra dependencies.

The passcode is generated with a cryptographically secure random generator at a
configurable length, and there is a wrong-attempt limit. Keep the mail path to your
users trustworthy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (plus the optional SMS dependencies).
2. [Configuration](configuration/index.md) — set the OTP options and labels, then
   place the reset form block.

## Where it lives in the admin menu

The settings form is at **Configuration → People → Reset Password Email OTP**
(`/admin/config/people/reset-password-email-otp`). You place the reset form via
**Structure → Block layout** (`/admin/structure/block`).
