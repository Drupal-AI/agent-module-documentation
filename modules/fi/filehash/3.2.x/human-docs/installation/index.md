# Installation

## Requirements

File Hash is a small, mostly core‑only module:

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **File** module (`file`), enabled — the only module dependency.
- For the **BLAKE2b** algorithms specifically, the **Sodium** PHP extension must be
  available (it ships with most modern PHP builds). The other 12 algorithms need nothing
  extra.
- *Optional:* the `yzalis/identicon` PHP library (`^2.0`) if you want to use the
  **Identicon** field formatter, which draws an avatar from a file's hash.

## Install with Composer

From the project root:

```bash
composer require drupal/filehash -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. To also pull in the Identicon library:

```bash
composer require drupal/filehash yzalis/identicon -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/filehash -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en filehash -y
```

Or enable **File Hash** from **Extend** (`/admin/modules`).

There are no submodules.

## Next steps

Enabling the module does **not** hash anything yet — no algorithm is switched on by
default. Open the settings form and enable at least one algorithm, then back‑fill any
existing files. See [Configuration](../configuration/index.md).
