# Change Mail Page — manual setup guide

**Change Mail Page** (`change_mail_page`) gives your users a dedicated,
access‑controlled page for changing just their email address, instead of hunting
for the email field on the full account‑edit form. When enabled, it adds a
**Change Email** tab to user profile pages, removes the email field from the main
user edit form for non‑administrators, and offers a handy `/user/change-mail`
shortcut that redirects to the current user's own change page.

The problem it solves is twofold: it streamlines a common self‑service task, and
it hardens it. Changing an email address is a sensitive operation — if an
attacker gets hold of a live session, quietly swapping the account's email is a
classic route to full account takeover. This module requires the account's
**current password** before the email can change, which blocks that path. The
form itself is gated by Drupal's built‑in `user.update` entity access, so a user
can change their own email and an administrator can change anyone's — while
administrators keep the email field on the normal user edit form.

The module works the moment you enable it; there is nothing you must configure.
It supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it works out of the box.

## Where it lives in the admin menu

Change Mail Page adds no admin settings page. Its user‑facing pages are:

- **Change Email** — a tab on each user's profile.
- `/user/{uid}/change-mail` — the change form for a specific user.
- `/user/change-mail` — a shortcut that redirects to the current user's own
  change form.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. As a regular user, open your profile and click the **Change Email** tab (or
   visit `/user/change-mail`).
3. Enter the new email address and your **current password**, then submit. The
   password check is required — without it the change is rejected.
4. Administrators can still edit any user's email directly on the standard user
   edit form; only non‑administrators have the email field moved to the dedicated
   page.
