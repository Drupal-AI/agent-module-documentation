# Installation

## Requirements

Registration Role is very lightweight. It needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).

There are no other module or third-party library dependencies. You will want at least one
role (besides *authenticated*) already defined, since that is what the module assigns.

## Install with Composer

From the project root:

```bash
composer require drupal/registration_role -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/registration_role -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en registration_role -y
```

## Grant the permission

The settings form requires the **Administer registration roles**
(`administer registration roles`) permission. Grant it to a trusted role at
**People → Permissions** (`/admin/people/permissions`), or with Drush:

```bash
drush role:perm:add site_manager 'administer registration roles'
```

Treat this as an administrative permission: because the settings form lists *every* role
except *authenticated*, anyone who holds it decides what every new registrant receives —
which is effectively a privilege-escalation control.

> **Upgrading from 8.x-1.x?** An old update hook granted this permission to every role that
> already had *Administer users*, so on upgraded sites it may be assigned more widely than
> you expect — review who has it.

## Next step

Nothing is assigned until you choose the roles — see
[Configuration](../configuration/index.md).
