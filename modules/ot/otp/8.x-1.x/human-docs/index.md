# OTP for account creation — manual setup guide

**OTP for account creation** (`otp`) changes how new accounts verify their email
address. Instead of Drupal's default "click the activation link in your email"
flow, it sends a **numeric one‑time code** and asks the registrant to type it in.
The account stays blocked until the code is entered, at which point the user is
logged in. The flow becomes:

1. The visitor submits the *Create new account* form.
2. The site emails them a verification code and shows a form to enter it.
3. Once the code is verified, the account is activated and the user is logged in.

Why a code instead of a link? An activation link is effectively a **credential
sitting in an email** — it can be consumed by a mail scanner or a link‑preview
bot before the real user ever sees it — and it pulls the user out of their browser
to their inbox, where a proportion never return. A code entered on the page keeps
people in the flow and is worth much less to something that merely follows URLs.

This module handles registration‑time email verification. It is **not** two‑factor
login (for that, look at TOTP/HOTP modules like `one_time_password`).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the OTP settings form and the
   security properties worth reviewing.

## Where it lives in the admin menu

The settings form is at **Configuration → People → OTP**
(`/admin/config/people/otp`), behind the **Administer site configuration**
permission. The verification form users see during registration is at
`/user/register/otp`.
