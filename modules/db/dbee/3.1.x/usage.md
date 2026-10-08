<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DataBase Email Encryption (dbee) transparently encrypts every user's email address (the `mail` and `init` columns of `users_field_data`) at rest using the Encrypt and Real AES modules, without changing the login, registration, or admin experience.

---

On install the module creates a Key entity (`dbee`, a 256-bit / 32-byte AES key, stored in a `private://dbee.key` file when a private files path is configured, otherwise base64 in config) and an EncryptionProfile (`dbee`, method `real_aes`), widens the `mail`/`init` columns to `text` and drops the `user_field__mail` index (ciphertext is longer than an email and not directly indexable), then encrypts all existing addresses. From then on it encrypts on write and decrypts on read entirely behind the scenes: `hook_entity_presave` / `hook_user_insert|update` encrypt before save; `hook_entity_load` decrypts loaded users (run early via `hook_module_implements_alter`); a custom `DbeeCookie` authentication provider decrypts the current user on session load; and `hook_query_alter` rewrites any dynamic query that filters on `mail`/`init` (e.g. `user_load_by_mail()`) by decrypting stored values in PHP and matching by uid — so email look-ups still work despite AES's random IV (this is CPU-intensive, hence a static cache). Because each address is separately encrypted, a core unique-email check cannot use SQL, so dbee swaps in a `UserMailUniqueDbee` validation constraint. Only syntactically valid emails are encrypted; invalid/empty values are left as-is. The module is admin-only (permission `administer dbee`, `restrict access`), points its "configure" link at the Encrypt profiles collection, reports encryption status on the status page and the user view page, and ships two Drush verify commands. Uninstalling decrypts everything back. Changing the key or profile triggers re-encryption (using a temporary `dbee_prev` profile to read the old data).

---

- Encrypt all user email addresses at rest to protect PII in the database.
- Meet GDPR / data-protection requirements for storing personal contact data.
- Keep emails unreadable in database dumps, backups, and replicas.
- Protect against email harvesting if the database is leaked or stolen.
- Encrypt without changing login, registration, or password-reset flows.
- Continue to look up accounts by email (`user_load_by_mail`) transparently.
- Preserve unique-email enforcement via the dbee replacement constraint.
- Store the encryption key as a file outside the database (`private://dbee.key`).
- Fall back to storing the key in config when no private files path exists.
- Use AES-256 (Real AES / defuse) as the encryption method via an Encrypt profile.
- Encrypt both the `mail` and the `init` (original registration email) columns.
- View each user's email encryption status on their account page.
- See a site-wide encryption health check on the Status report page.
- Verify that all users' emails decrypt correctly with `drush dbee:verify-users-decrypt-all`.
- Verify specific accounts with `drush dbee:verify-users-decrypt <uids>`.
- Rotate the encryption key and re-encrypt all stored emails.
- Change the encryption profile/method and have existing data re-encrypted automatically.
- Import the dbee key and profile via configuration sync on a fresh environment.
- Decrypt everything cleanly by uninstalling the module.
- Restrict encryption administration to trusted admins (`administer dbee`).
- Keep invalid or empty email values untouched (only valid emails are encrypted).
- Reduce exposure of contact data to third-party modules that read the users table.
- Harden a membership or community site that stores many user emails.
- Add at-rest email encryption to an existing site without data loss (batch re-encrypt on install).
