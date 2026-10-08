# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Authorization** module (`authorization`) enabled.
- The **Group** module (`group`) enabled, with at least one Group and Group type
  whose roles are defined.
- An Authorization **provider** — such as LDAP, OAuth, or SAML — enabled and
  configured, since this module is only the consumer half of the pattern.

Both `authorization` and `group` are contributed modules, so install them with
Composer if they are not already present.

## Install with Composer

From the project root:

```bash
composer require drupal/authorization_group -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in `authorization` and `group` if you do not
already have them.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/authorization_group -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en authorization_group -y
```

Enabling the module makes the **Groups** consumer available in the Authorization
profile UI. With no profile configured it does nothing on its own — continue to
[Configuration](../configuration/index.md) to wire it up.
