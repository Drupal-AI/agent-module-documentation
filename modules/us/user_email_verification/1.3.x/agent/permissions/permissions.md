# Permissions

One permission, defined in `user_email_verification.permissions.yml`:

- **`manage user email verification settings`** — `restrict access: true`. Gates the settings form
  route `user_email_verification.settings_form` (`/admin/config/people/user-email-verification`).
  Marked restricted because it controls the site's whole verification/blocking/deletion policy; grant
  only to trusted administrators.

There is no permission on the verification routes themselves — they are `_access: 'TRUE'` (anonymous)
by design and gated instead by the HMAC token + timestamp window (see
[api/service.md](../api/service.md)). Everything else (blocking, deletion, activation) is enforced by
cron/queue and by core user permissions such as `administer users`.
