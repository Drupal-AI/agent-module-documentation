# Installation

## Requirements

Attribution needs:

- **Drupal 10.5, 11.2, or 12** (`core_version_requirement: ^10.5 || ^11.2 || ^12`).
- The **`composer/spdx-licenses`** PHP library (`^1.5`), which supplies the SPDX
  license list the import feature reads from. Composer pulls this in automatically
  when you require the module.

There are no other module dependencies. The core **Token** module is optional but
useful — it lets you use token placeholders in the block disclaimers.

## Install with Composer

From the project root:

```bash
composer require drupal/attribution -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — here it also brings in `composer/spdx-licenses`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/attribution -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en attribution -y
```

Enabling the module installs nine common licenses (CC0, the CC‑BY family,
GPL‑2.0‑or‑later, and All Rights Reserved) so you can start immediately.

## Grant the permission

At **People → Permissions** (`/admin/people/permissions`), grant **Administer
attribution licenses** to the roles that should manage the license list.

Next, review and extend the license list and add an Attribution field — see
[Configuration](../configuration/index.md) and the
[overview](../index.md#how-to-use-it).
