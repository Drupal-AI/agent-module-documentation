<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DataBase Email Encryption (dbee) — agent index

Transparently encrypts the user `mail` and `init` columns of `users_field_data` at rest using
**Encrypt** + **Real AES**. No change to login/registration UX. Depends on `user`, `encrypt`,
`real_aes`. Admin-only (`administer dbee`). "Configure" points at the Encrypt profiles
collection (`entity.encryption_profile.collection`).

- **Install-created Key + EncryptionProfile (`dbee`), configure link, key rotation /
  profile change & re-encryption, status report** → [configure/setup.md](configure/setup.md)
- **How encryption/decryption works: fields, hooks, query rewriting, DbeeCookie, the
  UserMailUniqueDbee constraint, the dbee_encrypt/decrypt helpers, query tags** →
  [api/encryption.md](api/encryption.md)
- **Drush verify commands** → [drush/commands.md](drush/commands.md)
- **Permission `administer dbee`** → [permissions/permissions.md](permissions/permissions.md)

Key facts: profile `encrypt.profile.dbee` (method `real_aes`, key `dbee`); key
`key.key.dbee` (256-bit; `private://dbee.key` file when a private path exists, else config).
Encrypts on write (`entity_presave`/`user_insert`/`user_update`), decrypts on read
(`entity_load` early, `DbeeCookie` on session load), and rewrites `mail`/`init` WHERE clauses
via `hook_query_alter`. Only valid emails are encrypted. Uninstall decrypts everything back.
