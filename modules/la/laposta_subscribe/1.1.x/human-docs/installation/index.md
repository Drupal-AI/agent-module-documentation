# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Block** module (`block`) enabled — this is the only module dependency,
  and it is on by default in a standard install.
- A **Laposta account** with an API key and at least one mailing list.
- Optionally, the **Honeypot** module if you want its spam protection on the form.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/laposta_subscribe -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/laposta_subscribe -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en laposta_subscribe -y
```

> **Note:** this project is not covered by Drupal's security advisory policy.
> Weigh that according to your site's risk tolerance, and keep the module updated.

## Verify it worked

Confirm the module is enabled on the **Extend** page (`/admin/modules`). Next,
supply your API key and connect a list, then place the subscribe block — all
described in [Configuration](../configuration/index.md).
