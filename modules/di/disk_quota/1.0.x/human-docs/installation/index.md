# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- **PHP 8.1 or newer**.
- Core's **User** (`user`) and **File** (`file`) modules — both standard on a
  typical install and pulled in automatically as dependencies.
- No third‑party Composer packages or PHP libraries.
- *Optional:* the **Markdown filter** module, only so the module's `README.md`‑style
  help text renders nicely.

## Install with Composer

From the project root:

```bash
composer require drupal/disk_quota -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/disk_quota -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en disk_quota -y
```

You can also enable it from the **Extend** page (`/admin/modules`).

## Verify it worked

After enabling, go to **Configuration → People → Account settings → Disk Quota**
(`/admin/config/people/accounts/disk-quota`) and confirm the role‑based quota form
loads. Then set a small quota on a test role and confirm that a user in that role
is blocked from uploading once they exceed it.

## Uninstalling

Uninstalling the module (`drush pmu disk_quota`) removes all per‑user quota
overrides, and the role‑based configuration is removed from config.
