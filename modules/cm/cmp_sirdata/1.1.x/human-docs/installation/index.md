# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A **Sirdata CMP account** — create or log in at
  [sirdata.com](https://www.sirdata.com/), where you set up your CMP and obtain your
  Customer Key and App Key.

There are no other Drupal module dependencies and no third‑party PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/cmp_sirdata -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cmp_sirdata -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cmp_sirdata -y
```

## Verify it worked

After enabling, open the Sirdata CMP settings form and confirm you can enter your
Customer Key and App Key (see [Configuration](../configuration/index.md)). The consent
banner appears on the front end only once the module is enabled and both keys are saved.
