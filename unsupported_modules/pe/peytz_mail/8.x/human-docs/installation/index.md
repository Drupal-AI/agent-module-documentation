# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- A **Peytz Mail account** with an API key and the path (service URL) to your
  account.
- No special system requirements or third‑party PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/peytz_mail -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/peytz_mail -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en peytz_mail -y
```

## Set up permissions

After enabling, review the module's permissions at **People → Permissions**
(`/admin/people/permissions`) and grant them to the appropriate roles — for
example who may administer the Peytz Mail settings.

## Verify it worked

Log in as an administrator and open **Configuration → Peytz Mail → Settings**
(`/admin/config/peytz_mail/settings`). The settings form should load, ready for
you to enter the service URL and API key. Then continue with
[Configuration](../configuration/index.md) to connect your account and place the
signup block.
