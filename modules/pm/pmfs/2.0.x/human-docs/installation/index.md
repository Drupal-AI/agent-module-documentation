# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No third-party Composer or PHP library requirements.

Note that this is an older release (version 2.0.0, packaged in 2023). Verify its
behavior on your Drupal version before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/pmfs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pmfs -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pmfs -y
```

## Verify it worked

Log in as an administrator and visit **Configuration → System → Prevent Multiple
Form Submissions** (`/admin/config/system/pmfs`). You should see the settings form
where you choose which forms to protect. Configure at least one form (see
[Configuration](../configuration/index.md)), then submit that form twice in quick
succession — the second submission should be rejected with your configured error
message.
