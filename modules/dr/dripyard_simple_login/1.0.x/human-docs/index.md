# Dripyard Simple Login — manual setup guide

**Dripyard Simple Login** (`dripyard_simple_login`) replaces Drupal's usual
username‑and‑password login with **magic‑link (passwordless) authentication**.
Instead of typing a password, a user enters their email address on the login
page, receives a one‑time login link by email, and clicking it logs them straight
in. Users can still optionally set a password for traditional login if they
prefer.

What makes this module refreshingly lean is that it doesn't reinvent
authentication — it **repurposes Drupal core's password‑reset system**. The
`/user/login` route is swapped for a magic‑link form, core's password‑reset email
is used to deliver the one‑time login link, and a custom controller handles the
click with simplified messaging. Because it rides on core's mechanism, the link
is validated by core's own secure one‑time‑login token (an HMAC over the user's
ID, a timestamp, their last login, and their password hash, compared in
constant time and expiring after use or a time limit), and it reuses core's
password‑reset flood control to rate‑limit link requests. It also blocks direct
access to the standard password‑reset form so there's one consistent path in. It
depends only on core's **User** module and targets **Drupal 11**.

One thing to understand about any magic‑link login: account security becomes
**email‑account security plus link delivery**. Anyone who can read the user's
inbox — or intercept the email in transit — can log in. So make sure your mail is
delivered over TLS, keep the one‑time‑login link timeout appropriately short, and
think carefully before relying on it alone for highly privileged accounts.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

This module has **no settings form of its own**, but it does require **one manual
setup step** — editing core's password‑recovery email template — described in
"How to use it" below. Without that step the magic links won't be worded
correctly.

## Where it lives in the admin menu

Dripyard Simple Login adds no admin page. It changes the login experience
directly: the login form moves to **`/login`**. Its one required setup step and
its rate‑limiting both live on core's account settings page at **Configuration →
People → Account settings** (`/admin/config/people/accounts`).

## How to use it

### Required: update the password‑recovery email template

This module reuses the password‑reset email to deliver magic login links, so you
**must** update that template to word it as a login link:

1. Go to **Configuration → People → Account settings**
   (`/admin/config/people/accounts`).
2. Find the **Password recovery** email template and replace its body with
   something like:

   ```text
   [user:display-name],

   Below is your one time login link to [site:name].

   [user:one-time-login-url]/login?destination=/user

   This link will automatically expire after it has been used or 24 hours has past.

   If you prefer to use a password, you can set one here and then use it to log in instead: [user:one-time-login-url]

   -- [site:name]
   ```

3. Save the account settings.

### Optional: tune rate limiting

The module relies on Drupal core's flood protection to rate‑limit login‑link
requests. Adjust it under **Flood control** on the same **Account settings** page
if you need tighter or looser limits.

### Try it

Log out and visit **`/login`**. Enter an account's email address, then open the
resulting email and click the one‑time link — you should be logged straight in.
