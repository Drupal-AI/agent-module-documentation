# Webform User Registration — manual setup guide

**Webform User Registration** (`webform_user_registration`) lets a Webform create or
update a Drupal user account from a submission. It adds a single Webform *handler* called
**User Registration**: when an anonymous visitor submits the form it can create a new
account, and when a logged-in user submits it can update their own account — in both cases
by mapping your webform's elements onto user fields.

This is the module to reach for when you want a custom, branded registration form (with
whatever extra profile fields you like) instead of Drupal's stock user-register page. You
decide whether new accounts require administrator approval, require email verification, or
log the person in immediately, and you can assign roles to new accounts.

The module has no configuration page of its own — you configure it per webform, on the
handler. Its defaults are deliberately safe: account creation and account update are both
**off** until you enable them, and when creation is on, admin approval and email
verification both default to **on**.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.
2. [Configuration](configuration/index.md) — add the handler to a webform and set it up
   field by field (creation, update, field mapping, approval/verification/login).

## Where it lives in the admin menu

There is no site-wide settings page. You add and configure the handler on an individual
webform at **Structure → Webforms → (your webform) → Settings → Emails/Handlers → Add
handler → User Registration**.
