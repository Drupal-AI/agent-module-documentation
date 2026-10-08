# Installation

## Requirements

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`).
- Core's user registration form (part of the User module, always present).

There are no third-party Composer or PHP library requirements, and no other
modules to install.

## Install with Composer

From the project root:

```bash
composer require drupal/domain_registration -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/domain_registration -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en domain_registration -y
```

On a fresh install the domain list is empty, so **no restriction is applied yet**
and registration stays open. Head to the settings page to configure the rule — see
[Configuration](../configuration/index.md).

## Permission

The module adds one permission, **Administer domain registration**, which controls
access to the settings form. Grant it to trusted roles at
**People → Permissions** if you want someone other than a full administrator to
manage the allowed/blocked domain list.
