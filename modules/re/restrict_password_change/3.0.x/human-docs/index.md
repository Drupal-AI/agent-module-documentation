# Restrict Password Change — manual setup guide

**Restrict Password Change** (`restrict_password_change`) breaks Drupal's
all‑or‑nothing user administration into finer pieces. Normally, once you give a
role the core **Administer users** permission it can change *everything* about
other accounts — including their passwords, email addresses, and usernames, and
it can block or delete them. This module lets you hand out user management while
holding back the sensitive bits.

It does this by adding a set of granular permissions. When someone edits another
user's account, the module hides or disables the fields their role isn't allowed
to touch: no "change other users password" permission means the password field
disappears; no "change other users email" means the email field becomes read‑only;
and so on for username, block status, and the Delete action. It also governs
whether a user can change *their own* password, and whether password‑reset emails
are sent to a given account at all.

Crucially, the hidden fields aren't just visually hidden — Drupal's Form API
ignores any submitted value for them, so the restriction is enforced when the
form is saved, not merely in the browser. That makes this a genuine access
control, useful for delegating user administration to a help desk or support role
safely, separating "can edit user data" from "can change credentials", or forcing
SSO‑managed accounts to be unable to change their own passwords.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (core only, no dependencies).
2. [Configuration](configuration/index.md) — the permissions this module adds
   and exactly what each one controls.

## Where it lives in the admin menu

This module has no settings page of its own (`configure` is `null`). Everything
it does is controlled through permissions, on the standard
**People → Permissions** page (`/admin/people/permissions`).

## How to use it

The typical setup is:

1. Enable the module.
2. Create (or choose) a delegated role such as "User manager".
3. Give that role the core **Administer users** permission so it can edit
   accounts.
4. On **People → Permissions**, grant that role *only* the specific
   `change …` / `block …` / `delete …` permissions it should have, and withhold
   the rest. Anything you withhold is hidden or disabled on the user edit form
   for that role.
