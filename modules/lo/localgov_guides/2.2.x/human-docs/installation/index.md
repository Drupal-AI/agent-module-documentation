# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- **`localgov_core`** (part of the LocalGov Drupal distribution).
- Core **Block** (`block`), **Node** (`node`), and **Text** (`text`) modules — all
  enabled automatically as dependencies.

There are no extra third-party Composer libraries to install. It is designed for a
LocalGov Drupal site, though it will run anywhere `localgov_core` is present.

## Install with Composer

From the project root:

```bash
composer require drupal/localgov_guides -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/localgov_guides -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en localgov_guides -y
drush cr
```

Enabling the module adds the two content types (**Guide overview** and **Guide
page**) and the two navigation blocks. Rebuild caches (`drush cr`) so the new blocks
and routes register.

## After enabling

There is no configuration form. Start creating guides straight away — see the
[overview](../index.md#how-to-use-it) for the create-and-place-blocks walkthrough.

### Optional integration modules

To let guides sit in the services tree or be classified by topic, enable the
relevant module — the extra fields are imported for you:

```bash
drush en localgov_services_navigation -y   # guides inside the services tree
drush en localgov_topics -y                # guides classified by topic
```
