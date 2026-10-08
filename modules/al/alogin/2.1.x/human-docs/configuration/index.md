# Configuration

Authenticator Login has a small settings page plus a per-user enrolment page and
two permissions. This page walks through all three, and points out what you
should verify for your particular site.

## Open the settings form

1. Log in as a user with the **Administer alogin** permission.
2. Go to `/admin/config/alogin/config`.

Here you configure how 2FA is applied, including whether users are pushed through
enrolment after logging in.

## Assign the permissions

On **People → Permissions** (`/admin/people/permissions`) the module adds:

- **Administer alogin** — who may change the module's settings. Grant to
  administrators only.
- **Alogin bypass enforced redirect** — accounts with this permission are **not**
  forced through enrolment. Use it for service accounts or roles that should be
  exempt.

## Enrol a user's device

Each user sets up 2FA on their own page at `/user/{user}/2fa`:

1. Open the page for the account.
2. Scan the displayed **QR code** into an authenticator app (Google
   Authenticator, Authy, etc.).
3. The app then shows a rotating six-digit code for that account.

If enforced enrolment is on, users who have not yet enrolled are directed to do so
after logging in (unless they hold the bypass permission).

## Signing in with 2FA

After enrolment, logging in has two steps: the normal username and password, then
a `/2fa` form that asks for the current six-digit code from the authenticator app.

## What to verify for your site

Before relying on this as your only second factor, confirm it actually covers all
the ways people can log in to *your* site. The module gates the standard
username/password login form; Drupal can also authenticate through other paths
that may not pass through the code step, including:

- the **user login block**,
- the JSON login endpoint (`POST /user/login?_format=json`) when the core
  **serialization** module is enabled,
- authentication providers such as **basic_auth**, and
- the **one-time login link** from the password-reset email.

Check which of these are reachable on your site and confirm 2FA behaves as you
expect on each. Also be aware that the code check is not rate-limited by the
module, which is relevant to brute-force resistance. The [`agent/`](../agent/start.md)
docs describe the underlying mechanism in more technical detail.
