# Installation

## Requirements

- **Drupal 9, 10, 11, or 12** (`core_version_requirement: ^9 || ^10 || ^11 || ^12`).
- The **Domain** module (`domain`).

There are no third-party PHP or Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/domain_role_sync -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/domain_role_sync -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en domain_role_sync -y
```

This also enables the `domain` module if it is not already on.

## Verify it worked

Create a role for a domain (**People → Roles**), map it to that domain, then create
or save a user affiliated with the domain and confirm they pick up the mapped
role. See the [main guide](../index.md#how-to-set-it-up) for the setup steps.
