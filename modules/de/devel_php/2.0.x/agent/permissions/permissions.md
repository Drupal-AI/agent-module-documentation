# devel_php — permissions

From `devel_php.permissions.yml` — a single permission:

- **`execute php code`** — "Run arbitrary PHP from a block."
  Marked `restrict access: TRUE` (Drupal flags it as security-sensitive in the UI).

## What it gates

- Access to the Execute PHP page at `/devel/php` (route requirement `_permission: 'execute php code'`).
- Rendering of the "Execute PHP Code" block (`devel_execute_php`), whose `blockAccess()`
  calls `AccessResult::allowedIfHasPermission($account, 'execute php code')`.

## Security note

Holding this permission lets a user run `eval()` on the server as the web user — equivalent
to full site and server compromise. Grant it **only** to a single trusted developer role in
development, and **never** on production. There are no finer-grained permissions.
