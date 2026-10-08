# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.1 or newer** (`php: >=8.1`).
- The **Simple OAuth** module (`drupal/simple_oauth`, `^6`) — the module's key
  dependency, which also brings in the **Consumers** module. Simple OAuth requires
  a bit of its own setup (OAuth keys, at least one consumer); follow its
  documentation first.

There are no third‑party Composer packages or PHP libraries beyond what Simple
OAuth itself needs.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_oauth_password_grant -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update Simple
OAuth and any other shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_oauth_password_grant -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_oauth_password_grant -y
```

Enabling the module also enables Simple OAuth (and Consumers) if they aren't
already on. There's no settings page — the only thing to do next is tick
**Password** under a consumer's grant types. See the
[overview](../index.md#how-to-use-it), and mind the security warning there: use the
password grant only for trusted first‑party clients.
