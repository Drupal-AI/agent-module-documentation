# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`). Support for
  Drupal 8, 9, and 10.0–10.2 was dropped in this branch.
- The **Key** module (`drupal/key`, `^1`) — a hard dependency that manages the
  secret key material.
- **At least one encryption method module** — Encrypt ships no ciphers itself. The
  recommended default is **Real AES** (`drupal/real_aes`). Other options include
  Sodium, Encrypt KMS (Amazon KMS), and Encrypt RSA.

## Install with Composer

From the project root:

```bash
composer require drupal/encrypt -W
```

Then add an encryption method — Real AES is the recommended default:

```bash
composer require drupal/real_aes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Key module and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/encrypt -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the modules

```bash
drush en encrypt key real_aes -y
```

Key is enabled automatically as a dependency; the encryption method module (here
Real AES) must be enabled so a profile has a cipher to use.

## A note on storing key secrets

The secret key material should never be committed to version control. The
recommended pattern is to store it in an environment variable and expose it through
a Key entity:

1. Save the secret with DDEV's dotenv command, e.g.
   `ddev dotenv set .ddev/.env --encrypt-key=<value>` (keep `.ddev/.env` out of
   version control), then `ddev restart`.
2. Create a Key entity that reads from that environment variable using Key's env
   provider (at **Configuration → System → Keys**), or via `drush key:save`.

You'll then select that Key when building an encryption profile.

## Verify it worked

Go to **Configuration → System → Encryption profiles**
(`/admin/config/system/encryption/profiles`). If the profiles listing page loads
with an **Add encryption profile** button, Encrypt is active. Continue to
[Configuration](../configuration/index.md) to create a key and a profile.
