<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Defined in `drush.services.yml` → `Drupal\dbee\Commands\DbeeCommands`. Both commands **verify**
that stored emails decrypt correctly (they do not change data); results are reported via the
messenger. Batched at 1000 users per step.

| Command | Alias | Argument | What it does |
|---|---|---|---|
| `dbee:verify-users-decrypt-all` | `dbee-verify-all` | — | Verify email decryption for **all** users. |
| `dbee:verify-users-decrypt` | `dbee-verify` | `uids` (comma-separated) | Verify decryption for the listed user ids. |

Examples:

```bash
drush dbee:verify-users-decrypt-all
drush dbee-verify-all
drush dbee:verify-users-decrypt 1,2,42
```

A user is reported as failing when its `mail` column holds data that is a valid email that
should be encrypted but is not, or is not a decryptable email (corrupted/uncrypted). On success
you get "Users have correctly encrypted emails."; otherwise a warning lists the failing uids.
There is **no** encrypt/decrypt Drush command — bulk (re-)encryption happens automatically on
install, on key/profile change, and (decrypt) on uninstall.
