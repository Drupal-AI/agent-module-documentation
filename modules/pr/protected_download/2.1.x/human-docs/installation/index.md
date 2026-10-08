# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).

There are no third‑party Composer or PHP library requirements, and no other module
dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/protected_download -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/protected_download -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en protected_download -y
```

## Verify it worked

Go to **Configuration → Media → File system**
(`/admin/config/media/file-system`). You should see a new **File system path for HMAC
protected files** setting and a **Protected file system** fieldset. Configuring these
is the next step — see [Configuration](../configuration/index.md).
