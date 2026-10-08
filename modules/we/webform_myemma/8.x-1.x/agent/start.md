<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform MyEmma — agent start

**What**: Webform handler `myemma` that imports submitted emails + mapped fields into a
MyEmma group via `markroland/emma`. Depends on `webform`. Config at
`/admin/config/services/webform_myemma` (perm **administer webform myemma**).

## Set up
1. `composer require markroland/emma:^3.0`; `drush en webform_myemma -y`.
2. Settings page: enter default MyEmma **Account ID / public key / private key**; add extra
   named accounts if needed.
3. Add the **MyEmma** handler to a webform: choose Group ID (numeric; comma-sep for many),
   account, email element, and map elements → MyEmma field shortcuts.

## Key facts
- Config: `webform_myemma.settings` (default `account_id`/`public_key`/`private_key` +
  `accounts` list). Stored/displayed as plaintext (admin-only page).
- Handler: `WebformMyEmmaHandler::postSave()` runs on **new** submissions only; builds
  `MarkRoland\Emma\Client(...)` and calls `import_single_member($email, $fields, $groups)`.
- Errors logged to channel `webform_myemma`, not shown to users.
- TLS is handled by the `markroland/emma` client (no verify override in module code).
- Permission: `administer webform myemma`.
