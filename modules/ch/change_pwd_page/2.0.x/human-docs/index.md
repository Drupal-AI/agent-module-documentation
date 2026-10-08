# Password Separate Form — manual setup guide

**Password Separate Form** (`change_pwd_page`) moves password changing out of
Drupal's crowded account-edit form and onto a dedicated page at
`/user/change-password`. On a stock Drupal site, changing your password means opening
the full profile edit form — which also asks for your current password even when you
only wanted to update your email or some other field. This module removes the
password fields from that edit form and gives password changes their own focused page
instead.

Once enabled it does three things automatically: it hides the new-password widget on
the user edit form (and re-labels the current-password field), it adds a **Change
Password** tab to user profile pages plus a link in the account menu, and it reworks
the one-time-login / password-reset flow so that reset links land the user on the
separate change-password page. On that page the user must enter their current password
to set a new one — unless they arrived via a one-time login link, in which case that
step is skipped so they can set a fresh password.

The module works entirely on enable — there is **nothing to configure**. It has no
settings form, no configuration of its own, no permissions, and no Drush commands. It
depends only on core's **User** module. It also integrates neatly with the **Password
Policy** module if you use it: on install it points Password Policy's change-password
route at this module's separate form and shows the live policy-constraints table
there, so your password rules are enforced at the moment of change.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no admin settings page — the module has nothing to configure. Its user-facing
pages are the **Change Password** tab on each user profile
(`/user/{uid}/change-password`) and the shortcut `/user/change-password`, which
redirects the logged-in user to their own change-password form.

## How to use it

For end users, nothing needs setting up once the module is enabled:

- **Change your own password** — visit `/user/change-password` (it redirects you to
  your own form), or click the **Change Password** tab on your profile, or the
  **Change password** link in the account menu. Enter your current password and the
  new one, and save.
- **Editing your profile no longer asks for a password** — because the password fields
  are removed from the account-edit form, updating your email or other fields no
  longer prompts for the current password.
- **Administrators changing another user's password** — go to
  `/user/{uid}/change-password` for that user (this is subject to the normal permission
  to edit that user account).
- **After a password-reset email** — the one-time login link now lands the user on the
  separate change-password page, where they can set a new password without needing to
  know the old one. This makes it a natural "set your password" step for first-time
  logins.

## Password Policy integration

If you also run the **Password Policy** module, this module wires the two together
automatically on install: it sets Password Policy's `change_password_route` to point
at the separate change-password form, and it shows the live password-policy
constraints table on that form and validates policies there instead of on the account
edit form. There is nothing you need to click — just have both modules enabled. (If
Password Policy is not installed, none of this applies.)
