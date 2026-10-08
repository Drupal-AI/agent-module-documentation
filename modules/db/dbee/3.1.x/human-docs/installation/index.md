# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **User** module (always enabled).
- Two contrib modules, pulled in automatically by Composer:
  - **Encrypt** (`drupal/encrypt` `^3.1`) — the encryption framework and profiles.
  - **Real AES** (`drupal/real_aes` `^2.5`) — the AES-256 encryption method.

There are no additional PHP library requirements beyond what Real AES needs.

> **Plan for a maintenance moment.** On install, dbee encrypts every existing user
> email address in a batch and widens the email columns. On a large user base this
> takes a little time and rewrites the user table, so install it during a quiet
> period and take a database backup first.

## Install with Composer

From the project root:

```bash
composer require drupal/dbee -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Encrypt and Real
AES and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dbee -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dbee -y
```

Enabling dbee runs its install routine, which:

1. Generates a 256-bit AES **key** (entity id `dbee`).
2. Creates an **encryption profile** (`dbee`) using the Real AES method and that key.
3. Widens the user table's `mail` and `init` columns to hold the longer ciphertext.
4. **Encrypts all existing user email addresses** in a batch.
5. Adds an encryption-status indicator to each user's account page.

## Right after install

1. **Back up the key immediately** — see [Configuration](../configuration/index.md).
   This is the single most important step; losing the key means losing the ability
   to read your users' email addresses.
2. Check the **Status report** (`/admin/reports/status`) — it reports whether all
   user emails are encrypted.
3. Optionally run the verify command to confirm everything decrypts correctly:
   ```bash
   drush dbee:verify-users-decrypt-all
   ```

## Uninstalling is lossless

If you ever remove the module, its uninstall routine decrypts every email address
back to plaintext and restores the columns, so uninstalling does not lose data —
as long as the key is still present at that time.
