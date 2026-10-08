# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Encrypt** module (`encrypt`) — the required dependency. OpenPGP Encryption
  is a method plugin for Encrypt and does nothing on its own.
- The **Key** module (`key`) — Encrypt uses Key to store and reference the actual
  key material; you will need it to hold your PGP keys. It is normally installed
  alongside Encrypt.

## Install with Composer

From the project root:

```bash
composer require drupal/openpgp_encryption -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in the Encrypt module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/openpgp_encryption -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en openpgp_encryption -y
```

Drupal enables Encrypt (and Key) automatically as dependencies if they are
present.

## Handling your PGP keys safely

This is the part that matters most:

- A **public key** (`-----BEGIN PGP PUBLIC KEY BLOCK-----`) is used to encrypt and
  is not secret.
- A **private key** (`-----BEGIN PGP PRIVATE KEY BLOCK-----`) is used to decrypt
  and **must be protected**. Never commit it to Git, never paste it where it will
  be logged, and prefer a Key provider that reads it from an environment variable
  or a file stored outside the web root rather than keeping it in the database.

## Verify it worked

Go to **Configuration → System → Encryption profiles**
(`/admin/config/system/encryption/profiles`) and add a profile. In the encryption
method dropdown you should now see **OpenPGP** as an option. Selecting it and
choosing a stored key confirms the module is wired in correctly.
