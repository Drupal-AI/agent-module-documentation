# Email Verification — manual setup guide

**Email Verification** (`email_verification`) makes visitors prove they own an
email address **before** they can finish creating an account, so you don't end up
with spam accounts registered against non‑existent inboxes. It sits in front of
the standard user registration form: an anonymous visitor first enters an email
address, receives a verification link, and only after following that link can they
complete registration — with the email field pre‑filled and locked to the verified
address.

Under the hood the module intercepts the registration form for anonymous users
only (logged‑in users are unaffected), sends a link containing a hash of the email
address, and — when the visitor returns via that link — pre‑fills and marks the
email field read‑only. It adds no permissions of its own, reusing core's
**Administer users** permission for its settings, and it has no other module
dependencies.

The module needs a little configuration to work well: at minimum you should set a
strong random verification key (salt) and an email template. It relies on your
site's mail delivery being set up so the verification link actually reaches
visitors.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set the verification key, email
   template and help text.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → People → New User Email
Verification** (`/admin/config/people/userverify`). The visitor‑facing
verification request form lives at `/user/emailverify` (for anonymous visitors).
