# User Email Verification — manual setup guide

**User Email Verification** (`user_email_verification`) makes new users confirm
their email address after they register — but, unlike Drupal core, it lets them
choose a password and **log in immediately** at registration. Verification then
happens afterward: the user gets an emailed link and must click it within a time
window you set. If they don't, the module **blocks** the account (and can later
**delete** it).

This fills a real gap. Core's own email verification only works by *not* logging
the user in — it emails a one‑time login link instead. This module flips that
around: the user is logged in right away for a smooth first experience, while the
site still enforces that the address is real. The verification link is signed with
an HMAC keyed on your site's secret salt, so links can't be guessed or forged.

Enforcement runs on cron. During the verification window the module can send a
configurable number of reminder emails; when the window elapses, unverified
accounts are blocked. You can optionally grant an **extended grace period** with a
second link that re‑activates a blocked account, and decide whether accounts that
miss even that window are deleted or simply left blocked. Certain roles can be
exempted entirely.

It also adds some niceties: an "Email verified" indicator and date on user
profiles, a Views filter for verified vs. unverified users, a notification block
prompting the current user to verify, a page where a user can request a fresh link,
and — when the Rules module is present — events, conditions, and actions you can
build reactions on.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and the optional Token/Rules add‑ons.
2. [Configuration](configuration/index.md) — the **required** core account‑settings
   changes and the module's own settings form, field by field.

## Where it lives in the admin menu

The module's settings form is at **Configuration → People → User Email
Verification** (`/admin/config/people/user-email-verification`). Crucially, you
must *also* change core's settings at **Configuration → People → Account settings**
(`/admin/config/people/accounts`) for the module to work — see
[Configuration](configuration/index.md).

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)). The
   Token module is strongly recommended so you can place the verification link in
   the welcome email.
2. Adjust core's **Account settings** so users are logged in at registration and
   the welcome email carries the verification link — this is a *required* step,
   detailed in [Configuration](configuration/index.md).
3. On the module's own settings form, set the verification window, reminder count,
   email text, and (optionally) the extended grace period.
4. Make sure cron runs regularly — reminders, blocking, and deletion all happen on
   cron.

When you enable the module on an existing site, every current user is seeded as
already verified, so you won't lock anyone out.
