# Authenticator Login — manual setup guide

**Authenticator Login** (`alogin`) adds **two-factor authentication (2FA)** to
Drupal login using a TOTP authenticator app — the kind that shows a rotating
six-digit code (Google Authenticator, Authy, and similar). After a user enters
their password, they're asked for the current code from their app before they're
let in.

Each user enrols their own account at `/user/{user}/2fa`, where the module shows a
QR code to scan into their authenticator app. An event subscriber can require
users to finish enrolment after they log in, and a **bypass enforced redirect**
permission exists for accounts that should not be forced through enrolment. The
code is verified on a `/2fa` form that appears after the password step.

**A note on how strong the protection is.** The way this module enforces 2FA is
worth understanding before you rely on it as your only second factor. It hooks
the standard username/password login form and reroutes it through the code step —
but Drupal can authenticate by other routes too (the login *block*, the JSON
login endpoint when the `serialization` module is on, providers like
`basic_auth`, and the one-time login link from the password-reset email). Those
paths don't necessarily pass through this form. Before treating this as a complete
second factor, check which of those login paths are actually reachable on your
site. Also note the module does not add rate-limiting to the code check, so
consider that when assessing brute-force risk. None of this makes the module
useless — it means you should verify coverage for your specific setup. The
`agent/` docs go into the technical detail.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings page, per-user
   enrolment, permissions, and what to verify.

## Where it lives in the admin menu

The module's settings are at `/admin/config/alogin/config`, and each user enrols
their own device at **their** `/user/{user}/2fa` page. It provides two
permissions: **Administer alogin** and **Alogin bypass enforced redirect**.

## How to use it

1. Enable the module and open its settings page to configure enforcement.
2. Have each user visit their `/user/{user}/2fa` page and scan the QR code into an
   authenticator app.
3. On their next login, after the password they'll be prompted for the six-digit
   code on the `/2fa` form.

See [Configuration](configuration/index.md) for the details, including the login
paths you should verify.
