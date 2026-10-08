# Authenticate by Mail — manual setup guide

**Authenticate by Mail** (`authenticate_by_mail`) replaces the usual
username-and-password login with a **mailed one-time login link**. Instead of typing a
password, the user enters their email address and receives a link that logs them in
when clicked — a "magic link" or passwordless login. This removes passwords from the
login flow entirely, which can be a good fit for sites where you would rather users
never manage a password at all.

Under the hood it is implemented the right way: it **reuses Drupal core's own
one-time-login mechanism**, the same well-tested path core uses for password-reset
links. The link's hash is validated with `hash_equals()` against
`user_pass_rehash()` (core's per-user, CSPRNG-derived hash), the link **expires**, and
it is effectively **single-use** — the check rejects any timestamp earlier than the
user's last login, so once a link has been used it stops working. There is no home-grown
token scheme to worry about here.

Two operational points follow from how it works. First, **the login link is a
capability**: anyone who receives it can log in as that user, so it must travel only
over a mail path you trust. Second, because passwords are out of the picture,
**your email security becomes your authentication security** — the safety of the login
now rests on the safety of the mailbox and the mail channel, so protect those
accordingly (deliverability, transport security, mailbox access).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable
   it.

## How to use it

The module layers onto core's authentication and does not add a settings page of its
own. Once enabled:

1. At login, a user enters their **email address** instead of a password.
2. The module emails them a **one-time login link**.
3. Clicking the link logs them in; the link then expires and cannot be reused.

Because everything now flows through email, make sure of two things before you rely on
it:

- **Email delivery is reliable** — if mail does not arrive, users cannot log in. Verify
  your site's mail configuration.
- **The mail channel is secure** — the login link grants access, so treat it like a
  password in transit and keep the mailbox/mail path protected.
