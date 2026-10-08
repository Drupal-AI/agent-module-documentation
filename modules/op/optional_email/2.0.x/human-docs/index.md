# Optional Email — manual setup guide

**Optional Email** (`optional_email`) does one focused thing: it makes the email
address **optional** on Drupal's user registration form, so people can create an
account without supplying an email. Normally Drupal requires an email address at
registration; this module relaxes that requirement for sites where email simply
isn't part of the sign‑up flow — phone‑based registration, internal or intranet
sites, kiosk accounts, and similar cases.

The trade‑off is worth understanding before you enable it. An account with no email
address **cannot use Drupal's email‑based password reset**, and email is often a key
identity and anti‑abuse signal. Only turn this on if your registration flow already
has an alternative way to verify users and to help them recover access — for example
a phone number, an admin‑managed reset, or another identity check. Weigh the
anti‑abuse impact too, since a missing email lowers the barrier to creating throwaway
accounts.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form.
Enabling it is what makes the registration email field optional. It does provide a
permission, which you manage under **People → Permissions** as described below.

## How to use it

1. **Enable the module** (see [Installation](installation/index.md)). Once on, the
   email field on the registration form is no longer required.
2. **Review permissions.** Optional Email ships its own permission — visit **People
   → Permissions** (`/admin/people/permissions`) and grant it to the appropriate
   roles so the right users get the relaxed‑email behaviour.
3. **Confirm your recovery path.** Because accounts without an email can't use
   email‑based password reset, make sure the roles registering without email have a
   documented alternative way to regain access.
4. **Test the registration form** at `/user/register` to confirm the email field can
   be left blank for the intended users.

Supports Drupal 9, 10, and 11.
