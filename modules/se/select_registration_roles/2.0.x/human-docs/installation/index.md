# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **User** module (`user`), which is always present on a Drupal site.

There are no contrib, PHP, or third-party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/select_registration_roles -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/select_registration_roles -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en select_registration_roles -y
```

## Verify it worked

Before the role chooser will do anything, you must tell the module which roles to
offer — see [Configuration](../configuration/index.md). Once you have selected at
least one role there, visit `/user/register` (or view it as an anonymous visitor)
and confirm the role chooser appears with the roles you offered. Make sure visitor
self-registration is allowed under **Configuration → People → Account settings**
if you want anonymous users to register at all.
