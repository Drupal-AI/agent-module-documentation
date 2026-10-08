# Remove Username field — manual setup guide

**Remove Username field** (`remove_username`) gives your site an email‑only
identity model. It hides the separate "Username" field from Drupal's user
registration, account‑edit, login and password‑reset forms, makes the email
address required, and quietly copies the email into the account's `name`
(username) field — so people sign up and log in with just an email, and never
have to invent or remember a separate username.

There is nothing to configure. The module is a small set of form alterations
plus an entity‑presave hook. On the register and edit forms it hides the
username field and makes email required; on the login and password forms it
simply relabels the "Username" prompt to "Email address". Whenever any account
is saved — through the UI, Drush, a migration or custom code — the module forces
the username to match the email, so the two never drift apart. When you first
enable it, an install step walks every existing account and copies its email
into its username, so your current users adopt the rule immediately.

It also tidies up Commerce checkout: the returning‑customer field is relabelled
"Email address" and the register username field is hidden, so the email‑first
experience carries through to the store. The username column is still stored
behind the scenes (just hidden and kept in sync), which means Drupal's normal
rule that usernames must be unique still applies — a duplicate simply surfaces
as an "already taken" message on the email field.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere — Remove Username has no settings page, no permissions and no admin
links. Everything happens automatically once the module is enabled.

## How to use it

There is no setup beyond enabling the module. As soon as it is on:

- The **account registration** form (`/user/register` and the admin
  `/admin/people/create` flow) no longer shows a Username field, and Email is
  required.
- The **account edit** form no longer shows a Username field, so users cannot
  change it away from their email.
- The **login** and **forgotten‑password** forms label their first field
  "Email address" instead of "Username".
- Every account saved from now on — and every existing account, backfilled at
  install time — has its username set equal to its email.

To create a user "the Remove Username way" from code or a migration, just set the
email; the presave hook makes the username match automatically. To revert,
uninstall the module — existing usernames simply stay at whatever they were last
saved as (the email).
