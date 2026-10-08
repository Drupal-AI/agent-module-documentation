# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).

There are no other module dependencies and no third-party Composer or PHP library
requirements. You will need the domain-verification file issued by Apple as part of
your Apple Pay merchant setup.

## Install with Composer

From the project root:

```bash
composer require drupal/apple_pay_verification -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/apple_pay_verification -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en apple_pay_verification -y
```

There are no submodules. After enabling, grant the module's upload permission to
the appropriate administrator role at **People → Permissions**
(`/admin/people/permissions`), then upload Apple's verification file — see
[How to use it](../index.md#how-to-use-it).
