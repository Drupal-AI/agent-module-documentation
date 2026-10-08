# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).

There are no other module dependencies and no third‑party Composer or PHP library
requirements. The module works with the file directories your site already uses
(`public://`, `private://`, and the default files directories).

> **Heads up:** this project is **not covered by Drupal's security advisory
> policy**. Because the tool can read and package files from the server, treat the
> `administer pdf manager` permission as sensitive and grant it only to trusted
> administrators (see [Configuration](../configuration/index.md)).

## Install with Composer

From the project root:

```bash
composer require drupal/pdf_manager -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pdf_manager -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pdf_manager -y
```

## Verify it worked

Log in as an administrator and go to **Content → PDF Manager**
(`/admin/content/pdf-manager`). Run a scan — the page should report the number of
PDF files found and their combined size. If the menu item or page is missing,
confirm your user has the **administer pdf manager** permission (see
[Configuration](../configuration/index.md)).
