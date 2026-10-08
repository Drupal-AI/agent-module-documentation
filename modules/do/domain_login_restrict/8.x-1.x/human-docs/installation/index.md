# Installation

## Requirements

- **Drupal 8, 9, 10, 11, or 12** (`core_version_requirement: ^8 || ^9 || ^10 || ^11 || ^12`).
  That five-major span is a statement of intent rather than proof of testing on
  every one, so test on your own core version.
- The **Domain** module (`domain`) and **Domain Access** (`domain_access`), both
  from the Domain project. Drupal will pull these in as dependencies.

There are no third-party PHP or Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/domain_login_restrict -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/domain_login_restrict -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en domain_login_restrict -y
```

This also enables `domain` and `domain_access` if they are not already on.

## Verify it worked

The module does not restrict anything until you switch it on. Go to
**Configuration → Domain → Settings** (`/admin/config/domain/settings`) and
confirm you see the *Domain User: Login restrict* section. Tick the checkbox to
enable the global affiliation check, then see the
[main guide](../index.md#how-to-configure-it) for the full configuration options,
including per-domain role restrictions and the `login to any domain` permission.
