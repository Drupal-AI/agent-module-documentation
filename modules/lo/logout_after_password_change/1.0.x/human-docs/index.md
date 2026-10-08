# Logout After Password Change — manual setup guide

**Logout After Password Change** (`logout_after_password_change`) is a small
session‑security module that forces a user to be logged out immediately after
their password is changed or reset, requiring them to sign in again with the new
password. It's a piece of good session hygiene: once credentials change, the old
session shouldn't quietly continue.

The module works through an event subscriber that calls Drupal's `user_logout()`
when a password‑reset flag is set, so the session is terminated right after the
change. As the project describes it, while the reset is in progress the user can
only visit their own `user/{uid}/edit` page and change *just* the password —
anything else logs them out.

There is nothing to configure and nothing to enable beyond the module itself: it
adds no settings form, no permissions, and no blocks. Enable it and the behaviour
is active. It supports Drupal 9, 10, and 11.

This is a security‑positive feature — it helps ensure a changed password actually
takes effect for the session and supports "log out everywhere after a credential
change" style behaviour.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form.
Enable it and the forced logout is active immediately.

## Where it lives in the admin menu

Logout After Password Change adds no admin page and no settings. Its only visible
effect is behavioural: after a user changes or resets their password, they are
logged out and redirected to the login page to sign in again with the new
password.
