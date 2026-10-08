<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# REST Password Reset (rest_password_reset) — agent index

REST endpoints for a **decoupled/headless** Drupal frontend to retrieve a username, request a
password-reset email, and set a new password. Package/service area: web services. Core
`^10 || ^11`. License GPL-2.0-or-later. Version **1.1.x**.

- **Depends on** core `rest`, core `user`, and contrib `restui` (REST UI). No composer.json;
  no PHP/library deps. Requires a decoupled frontend to consume the emailed reset link.
- **Provides:** three REST resource plugins, one admin config form + config object, one
  permission, a token, and a `hook_mail()`. No entities, no plugin types, no Drush.

## Solution docs

- The three REST endpoints (request/response shape, hashing, flood control) →
  [api/endpoints.md](api/endpoints.md)
- The admin settings form, config object/schema, the reset-link token →
  [config/settings.md](config/settings.md)

## What it actually is (from source)

- **`src/Plugin/rest/resource/ResetLink.php`** — id `rest_password_reset_link`, GET
  `canonical = /api/user/reset/{mail}`. Emails a one-time reset link for the account with that
  email.
- **`src/Plugin/rest/resource/Username.php`** — id `rest_password_reset_username`, GET
  `canonical = /api/user/username/{mail}`. Emails the account username.
- **`src/Plugin/rest/resource/PasswordReset.php`** — id `rest_password_reset_password`, POST
  `create = /api/user/reset/password`. Consumes JSON `{uid, timestamp, hash, new_password}` and
  saves the new password.
- **`src/Form/PasswordResetConfigForm.php`** — settings form at
  `/admin/config/services/rest-password-reset` (route `rest_password_reset.password_reset`),
  editing config object `rest_password_reset.password_reset`.
- **`src/Access/PasswordResetAccessCheck.php`** — `_custom_access` for the form route; allows
  `administer site configuration` OR the `rest password reset` permission.
- **`rest_password_reset.tokens.inc`** — token `[rest_password_reset:login_link]` builds the
  frontend reset URL. **`rest_password_reset.module`** — `hook_mail()` for the two mail keys.

## Operate it

1. Enable the module (pulls in `rest`, `user`, `restui`).
2. In **REST UI** (`/admin/config/services/rest`), enable the three resources, choose formats
   (e.g. `json`) and authentication (e.g. `cookie`), and grant the anonymous role the matching
   `restful get/post ...` permissions so the frontend can call them.
3. At **`/admin/config/services/rest-password-reset`** set the frontend base URI (`fe_uri`,
   required), optional custom suffix, and the email subjects/bodies. See
   [config/settings.md](config/settings.md).
