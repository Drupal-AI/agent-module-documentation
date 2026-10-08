# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- No other modules, no third‑party Composer packages, and no PHP library
  requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/mail_denylist -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/mail_denylist -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mail_denylist -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → System → Mail Denylist**
(`/admin/config/system/mail-denylist`). You should see the denylist management
page. Add a throwaway address, then trigger an email to it from your site — the
message should not be delivered. See [Configuration](../configuration/index.md)
for the details.
