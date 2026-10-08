# User Redirect — manual setup guide

**User Redirect** (`user_redirect`) sends users to a URL you choose the moment they
log in or log out — and it can pick a different destination for each user role.
Administrators can land on `/admin/content`, editors on a `/dashboard`, customers
on an external portal, and everyone can be bounced to the front page on logout,
all configured from one form and without writing a custom `hook_user_login()`.

Each role gets its own **Login** and **Logout** redirect URL, plus a weight. When a
user belongs to several roles, the weights decide which destination wins (the
highest-priority role's URL is used). Both internal Drupal paths (starting with
`/`) and full external URLs (`https://…`) are accepted. An **ignore list** lets you
name paths that should *not* be redirected — the shipped default ignores
`/user/reset/*` so one-time password-reset login links are never hijacked.

The module works only after you configure it: it ships with no default settings, so
until you open the settings form and save it once, nobody is redirected. It depends
on core's **User** and **Path alias** modules, adds one permission
(*Administer User Redirect Settings*), and has no submodules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form, field by field:
   per-role login/logout URLs, weights, and the ignore list.

## Where it lives in the admin menu

The settings form sits under **People** — go to **Administration → People** and
open the **User Redirect** settings, or navigate directly to
`/admin/people/users/redirect/form/settings`. It is gated by the *Administer User
Redirect Settings* permission.
