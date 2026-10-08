# TFA Email Support — manual setup guide

**TFA Email Support** (`tfa_email_support`) is a lightweight plugin for the **TFA
(Two-Factor Authentication)** module that adds **email** as a second factor. By
default TFA does not offer email one-time passcodes; this module fills that gap, so
a user completing login receives a 6-digit code by email and must enter it to
finish signing in — no SMS, authenticator app, or third-party service required.

It plugs straight into TFA. It ships a validation plugin used at login (which
generates the code, emails it, and checks what the user types) and a setup plugin
that walks a user through enrolling their email as a second factor: they enter an
email address, receive a verification code, and confirm it. The code the user is
sent is stored temporarily with a short expiry, can be resent after a 120-second
cooldown, and is cleared once login succeeds; a routine cron job purges any expired
codes. If a user has not set a dedicated TFA email, the module falls back to their
account email, and the recipient address is masked in the login form.

The emails themselves are fully customisable. An admin form lets you edit the
subject and body for the login OTP, the enrolment code, and backup-code messages,
with dynamic tokens such as `@otp`, `@username`, `@site_name`, and `@ip_address`,
optional HTML templates, and custom headers or a reply-to address. The module
requires the **TFA** module and supports Drupal 10 and 11. It provides no config
schema route in the usual place — its settings live at a dedicated email-templates
form described below — and it adds no anonymous or mutating endpoints of its own
beyond the TFA login flow it hooks into.

Codes are short-lived, TFA's own flood control limits repeated attempts, and codes
are stored in Drupal's `state` store with short expiries and are not written to
logs. This module is not covered by Drupal's security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install TFA and this plugin, enable
   both, and select Email OTP as a validation method.
2. [Configuration](configuration/index.md) — the email-templates form, field by
   field, and how enrolment and login work.

## Where it lives in the admin menu

Once enabled, you turn on Email OTP from the main TFA settings at **Configuration →
People → TFA** (`/admin/config/people/tfa`), where Email OTP becomes selectable as
a validation plugin. The module's own email-templates form sits at
`/admin/config/people/tfa/email-templates`.
