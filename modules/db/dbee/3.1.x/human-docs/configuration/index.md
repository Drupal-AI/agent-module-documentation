# Configuration

dbee configures itself on install, so there is no settings form to fill in. What
you *do* need to understand is where the encryption **key** and **profile** live,
how to protect and rotate the key, and how to verify that encryption is working.
All of this happens through the Encrypt and Key modules' own UIs, which dbee reuses.

## Where the key and profile live

- **The encryption profile** — a profile named `dbee` at **Configuration → System
  → Encryption profiles** (`/admin/config/system/encryption/profiles`). It uses the
  Real AES (AES-256) method and points at the `dbee` key.
- **The key** — a key named `dbee` at **Configuration → System → Keys**
  (`/admin/config/system/keys`). On install, dbee chooses the safest storage
  available:
  - a **file** at `private://dbee.key` when your site has a writable private files
    path configured — the recommended setup, because the key then lives outside the
    database; otherwise
  - **inside configuration** (base64-encoded, stored in the database) as a fallback.

Both entities are protected: only users with the **Administer database email
encryption** permission can view or edit the `dbee` key and profile. Treat that
permission as highly sensitive — it grants access to the key that protects every
user's email address.

## Back up your key — and keep it separate

This is the most important thing on this page.

**If you lose the `dbee` key, the encrypted email addresses cannot be
recovered.** There is no master password or recovery path — the key *is* the only
way to read the data.

- If the key is stored as a **file** (`private://dbee.key`), make sure that file is
  included in a secure, encrypted backup — and ideally stored **separately** from
  your database backups, so that a stolen database backup doesn't also contain the
  key that unlocks it.
- If the key is stored **in configuration**, it travels with your config/database;
  make sure those backups are themselves protected.
- **Never delete the `dbee` key or profile while the module is enabled.** Without
  them the stored emails cannot be decrypted, and the site will not be able to read
  its own user email addresses.

When moving the site between environments, carry the key with you. If the key on
the target environment differs from the one the data was encrypted with, the emails
will not decrypt.

## Rotating the key (or changing the profile)

Because dbee uses ordinary Encrypt and Key entities, you rotate the key through
their normal UIs — and dbee reacts automatically:

- If you **change the key's value**, or change the **profile's** method or key,
  dbee **re-encrypts all stored emails**. It reads the existing data with the old
  key (through a temporary internal profile), then re-writes everything with the new
  key.
- Back up the key **before and after** a rotation, and take a database backup first.
  Verify afterward (see below).

## Verifying encryption

dbee never leaves you guessing whether the data is really encrypted:

- **Status report** — **Reports → Status report** (`/admin/reports/status`) shows
  whether all user emails are currently encrypted.
- **User account page** — each user's account page shows that account's encryption
  status.
- **Drush verify commands** — these check that stored emails decrypt correctly
  without changing any data (processed in batches of 1000 users):

  ```bash
  # Verify every user
  drush dbee:verify-users-decrypt-all      # alias: dbee-verify-all

  # Verify specific user IDs
  drush dbee:verify-users-decrypt 1,2,42   # alias: dbee-verify
  ```

  On success you'll see "Users have correctly encrypted emails."; otherwise a
  warning lists the user IDs that failed.

There is deliberately **no** bulk encrypt/decrypt Drush command — encryption of all
emails happens automatically on install, re-encryption happens automatically on a
key or profile change, and decryption back to plaintext happens automatically on
uninstall.

## Config sync note

dbee is safe to deploy through configuration synchronization. If a config import
already contains the `dbee` key and profile, they are reused rather than
regenerated; if not, they are created, and emails are (re-)encrypted at the end of
the import. As always, make sure the exported/deployed key matches the data you are
moving.
