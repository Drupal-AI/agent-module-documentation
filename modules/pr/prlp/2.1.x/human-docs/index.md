# Password Reset Landing Page (PRLP) — manual setup guide

**Password Reset Landing Page** (`prlp`) lets a user set a brand-new password
**right on the one-time-login page** they reach from a password-reset email —
instead of the usual two-step dance of logging in first and then editing their
account to change the password. The moment they click the reset link, they can
type and confirm a memorable password and be on their way.

It works by adding a "Set New Password" field to Drupal's standard password-reset
landing form and, when the one-time login succeeds and a new password was entered,
saving that password before redirecting the user onward. The one-time-login link
keeps all of core's security — expiry and flood control still apply — so you get a
friendlier recovery flow without loosening anything. Invalid or reused links are
handled gracefully: the user is logged out and prompted to request a new one.

Two settings let you tune it: whether the new-password field is **required** (on by
default) or optional, and the **destination** the user lands on after logging in
(their account edit page by default, but you can send them to the front page, a
dashboard, or an onboarding path using `%user` and `%front` tokens). PRLP adds an
**Administer PRLP settings** permission for who can change those, ships an optional
**PRLP Password Policy** submodule that enforces the Password Policy module's rules
on the reset page, and has no third-party dependencies. Nothing needs configuring
beyond enabling the module — it works out of the box.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including the route
override, the form alter, and the two dispatched events — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and optionally the Password Policy integration submodule.
2. [Configuration](configuration/index.md) — the two settings (required field and
   login destination) and the destination tokens.

## Where it lives in the admin menu

Once enabled, the settings form sits under **Configuration → People → Account
settings → PRLP** (`/admin/config/people/accounts/prlp`).

## How to use it

There's nothing to wire up. Once the module is enabled, the next time anyone uses
the "reset your password" flow, the landing page will include the *Set New
Password* field. Visit the settings form only if you want to make that field
optional or change where users go after they log in.
