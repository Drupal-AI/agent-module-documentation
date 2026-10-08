<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Security Review checks enabled

The recipe ships 14 `security_review.check.*` config entities (one per file in
`recipes/default/config/`). Each is a minimal config record — just an `id` — that registers/enables
the corresponding Security Review check plugin. `security_review.settings` (see `recipe.md`) marks
`anonymous` as an untrusted role and enables logging, so checks that evaluate "what untrusted users
can do" use that role.

## Checks (`id`)
- `security_review-admin_permissions` — untrusted roles must not hold admin/restricted permissions.
- `security_review-error_reporting` — verbose error messages are not shown on screen.
- `security_review-executable_php` — PHP cannot be executed from the files directory.
- `security_review-failed_logins` — reports failed-login activity.
- `security_review-field` — text fields do not contain dangerous (PHP/JS) markup.
- `security_review-file_perms` — filesystem permissions are not overly permissive.
- `security_review-input_formats` — untrusted roles cannot use unsafe (full HTML/PHP) text formats.
- `security_review-private_files` — the private files directory is outside the web root.
- `security_review-query_errors` — watches for repeated database query errors (possible SQLi probing).
- `security_review-temporary_files` — no stray temporary files left in the codebase.
- `security_review-trusted_hosts` — trusted host settings configured (this one sets
  `settings.method: token`).
- `security_review-upload_extensions` — dangerous upload file extensions are not allowed.
- `security_review-views_access` — Views have access control (not left open).

## Running the report
Visit the Security Review report at `/admin/reports/security-review` (permission "run security checks"
/ "access security review list"), configure untrusted roles/skipped checks at
`/admin/reports/security-review/settings`, or run `drush security-review` (alias `drush secrev`).

![Security Review report page listing the pre-configured checks](../../../../../../../screenshots/websecurity/12.0.x/security-review-report.png)
