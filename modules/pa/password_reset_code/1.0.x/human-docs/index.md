# Password Reset Code — manual setup guide

**Password Reset Code** (`password_reset_code`) changes how users recover a
forgotten password. Instead of (or alongside) Drupal's standard one‑time login
link, it sends the user a short **verification code** by email. The user requests a
reset, receives the code, enters it, and then sets a new password. For many sites
this is a friendlier, more familiar flow — especially where users are on a
different device from the one that received the email.

What makes this module worth singling out is that the code‑based reset is
**implemented carefully**. The verification code is generated with a cryptographically
secure random number generator, compared using a timing‑safe comparison, limited to
a configurable number of attempts (so a short code cannot be brute‑forced),
expires after a configurable time, and is **single‑use** — the reset record is
deleted after a successful reset and on expiry. Those are exactly the properties a
code‑based reset needs to be safe.

Because this is an authentication feature, two things are worth setting well: keep
the **attempt limit** low and the **expiry** modest, and make sure the path your
reset emails travel is trustworthy — as with any emailed secret, the security of
the flow depends on the mailbox and the transport.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — set the code expiry and attempt
   limit, customize the user messages, and edit the reset email template.

## Where it lives in the admin menu

After enabling, the module adds its settings at **Administration → Configuration →
People → Password reset by code**. The reset email template lives with the account
messages at **Administration → Configuration → People → Account settings**. Both
are covered in [Configuration](configuration/index.md).

## How to use it (for your users)

From the user's side, the flow is simple:

1. Go to the password reset page and enter your email address.
2. Check your email for the password reset code (and the accompanying reset link).
3. Follow the link and enter the verification code to set a new password.

Administrators can also manage active reset codes — viewing, revoking, or
extending them — from the same **Password reset by code** area.
