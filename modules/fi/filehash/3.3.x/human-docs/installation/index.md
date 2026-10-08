# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **File** module (`file`) — the only module dependency.
- **Optional libraries:**
  - The **Sodium** PHP extension (or the `paragonie/sodium_compat` polyfill) — only
    needed if you want to use the **BLAKE2b** family of algorithms.
  - `yzalis/identicon` (`^2.0`) — only needed if you want the **Identicon** field
    formatter, which draws an avatar image from a file's hash.

## Install with Composer

From the project root:

```bash
composer require drupal/filehash -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If you want the Identicon formatter, also require its
library:

```bash
composer require yzalis/identicon -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/filehash -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en filehash -y
```

Enabling the module does **not** start hashing anything — all algorithms are off by
default. Head to [Configuration](../configuration/index.md) to turn on the ones you
want.

## Verify it worked

Go to **Configuration → Media → File Hash** (`/admin/config/media/filehash`); you
should see the settings form listing all 18 algorithms. Enable one (for example
SHA‑256) and save, then upload a file through any file field. The file's hash is now
computed and stored — you can confirm it via a token like `[file:filehash-sha256]`,
the `filehash_table` formatter, or by checking the new column on the `file_managed`
table. To backfill hashes for files that existed before you enabled the module, run
`drush filehash:generate` (see [Configuration](../configuration/index.md)).
