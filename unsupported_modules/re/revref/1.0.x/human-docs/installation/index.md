# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **System** (`system`) and **Field** (`field`) modules — both are always
  present on a standard Drupal install and are pulled in automatically.

There are no third-party Composer or PHP library requirements. Note this release
(1.0.0-alpha2) is not covered by Drupal's security advisory policy yet, so review
it before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/revref -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/revref -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en revref -y
```

## Review the defaults

After enabling, review the module's configuration in `revref.settings.yml` (via
your configuration management workflow). The key setting is
**`index_entity_types`** — which entity types are included in the asynchronous
performance index. Lookups still work for entity types outside the index; they
simply fall back to a query rather than the fast indexed read.

## Verify it worked

Confirm the lookup service is registered:

```bash
drush php:eval "var_dump(\Drupal::hasService('reverse_reference.lookup'));"
```

A result of `bool(true)` means the module is active. From there you can add a
computed *Reverse entity reference* field on an entity type's **Manage fields**
screen, or call the service from your own code — see the "How to use it" section of
the [overview](../index.md).
