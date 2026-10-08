# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- Core's **Block** (`block`) and **User** (`user`) modules — both are Drupal
  core and are enabled automatically as dependencies.
- A working **APSIS account** with API access, so you have an API key and know
  which APSIS environment (host and port) to point at.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/apsis_mail -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/apsis_mail -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en apsis_mail -y
```

Enabling it pulls in the core Block and User modules if they are not already on.
A default APSIS endpoint (`se.api.anpdm.com:8443`) ships in configuration, but
you still need to enter your own API key before subscriptions will work — see
[Configuration](../configuration/index.md).

This module has no submodules.
