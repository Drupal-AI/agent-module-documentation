# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- No module dependencies and no third‑party Composer or PHP library requirements.

This is a development/testing aid — install it on the environments where you want
file links to resolve against production, not on production itself.

## Install with Composer

From the project root:

```bash
composer require drupal/files_url_replacer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/files_url_replacer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en files_url_replacer -y
```

## Grant the admin permission

The settings form is gated by its own **Administer files_url_replacer settings**
permission (declared as a restricted permission). Grant it only to trusted
administrators at **People → Permissions** (`/admin/people/permissions`).

## Verify it worked

Log in as an administrator and visit **`/admin/config/files_url_replacer`**. If the
settings form loads, the module is installed. Configure it — see
[Configuration](../configuration/index.md) — then load a page with images that
don't exist locally and confirm they resolve against your configured host.
