# DataBase Email Encryption — manual setup guide

**DataBase Email Encryption** (`dbee`) encrypts the email addresses your Drupal
site stores in its database, so that at rest they are AES-256 ciphertext rather
than readable plaintext. If someone obtained a copy of your database — a leaked
backup, a compromised host — the user email addresses inside it would be
unreadable without the encryption key. This is a common requirement for privacy
and GDPR-style "protect personal data at rest" obligations.

The best part is that it is **transparent**. Logging in, registering, editing an
account, resetting a password, sending site email — none of it changes for your
users or your editors. Behind the scenes the module encrypts the two email
columns of the user table (`mail`, and `init`, the address an account originally
registered with) when they are written, and decrypts them when Drupal reads them.
Look-ups "by email address" still work because the module transparently handles
the matching for you.

It builds on two well-established modules: **Encrypt** (which provides the
encryption framework and profiles) and **Real AES** (which provides the AES-256
method). On install, dbee sets everything up for you automatically: it generates a
256-bit encryption **key**, creates an encryption **profile** called `dbee`, and
encrypts every email address already in your database in one batch. There is no
settings form to fill in.

Because everything hinges on that one key, this module comes with a serious
responsibility: **back up your encryption key and keep the backup safe and
separate.** If you lose the key, the encrypted email addresses cannot be
recovered. See [Configuration](configuration/index.md) for where the key lives and
how to protect it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Encrypt /
   Real AES dependencies with Composer and enable it.
2. [Configuration](configuration/index.md) — where the key and profile live,
   backing up the key, rotating it, and verifying encryption.

## Where it lives in the admin menu

dbee has no configuration page of its own. Its "Configure" link takes you to the
**Encrypt profiles** list at **Configuration → System → Encryption profiles**
(`/admin/config/system/encryption/profiles`), where the auto-created `dbee`
profile lives. The matching key is managed under the **Key** module's UI at
**Configuration → System → Keys** (`/admin/config/system/keys`). You can also
confirm the overall encryption status on the site **Status report**
(`/admin/reports/status`) and on each user's account page.
