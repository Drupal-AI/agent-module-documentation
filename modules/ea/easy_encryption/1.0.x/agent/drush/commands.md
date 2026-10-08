<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

`Drupal\easy_encryption\Drush\Commands\EasyEncryptionCommands` (requires drush ≥ 13.7; the module
`conflict`s with older drush).

## `easy-encryption:rotate` (alias `ee:rotate`)

Rotate the active encryption key and optionally re-encrypt all `easy_encrypted` keys.

Options:

- `--reencrypt` — re-encrypt all Key entities using the `easy_encrypted` provider to the new key.
- `--dry-run` — show what would change (active key, totals, would-update/skip counts); no changes.
- `--no-fail` — return success even if some credentials fail to re-encrypt (still reported).

Examples:

```bash
drush easy-encryption:rotate --dry-run --reencrypt   # preview counts
drush easy-encryption:rotate --reencrypt             # rotate + re-encrypt (asks to confirm)
```

Behavior: prompts for confirmation; prints old/new active key ids and, with `--reencrypt`,
updated/skipped/failed counts. Non-zero exit if re-encryption failed and `--no-fail` was not set.
Backed by `KeyRotatorInterface`.

## `easy-encryption:migrate-private-key` (alias `ee:migrate-private-key`)

Migrate the active private key from database (State) storage to the filesystem.

Options:

- `--check` — only report whether migration is needed; don't perform it.

```bash
drush easy-encryption:migrate-private-key --check
drush easy-encryption:migrate-private-key
```

Behavior: if the active private key is already on the filesystem (or none configured) it reports "no
migration needed"; otherwise it confirms and migrates. Backed by `PrivateKeyStorageMigrator`. The
same migration is offered in the Admin UI (`easy_encryption_admin.migrate_private_key`).
