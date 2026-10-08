# Installation

## Requirements

- **Drupal 8.7.7, 9, or 10** (`core_version_requirement: ^8.7.7 || ^9 || ^10`).
- These modules, which Composer/Drupal pull in as dependencies:
  - **Entity** (`entity`)
  - core **Datetime** (`datetime`)
  - core **Views** (`views`)
  - core **Link** (`link`)
  - core **Block** (`block`)
- A **Guest Suite account** with an **API access token**, so the module can
  authenticate to the Guest Suite REST API.

## Install with Composer

From the project root:

```bash
composer require drupal/guest_suite -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in the Entity module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/guest_suite -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en guest_suite -y
```

Drupal enables the Entity, Datetime, Views, Link, and Block dependencies at the
same time.

## Verify it worked

Go to **Configuration → Web services → Guest suite**
(`/admin/config/services/guest-suite`). If the settings form loads, the module is
installed. After you enter a valid access token (see
[Configuration](../configuration/index.md)) and run an import, confirm that
`guest_suite_review` entities appear in the review collection.
