# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- No third-party libraries and no other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/module_missing_message_fixer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/module_missing_message_fixer -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en module_missing_message_fixer -y
```

There are no submodules.

## Grant the permission

The module defines a single permission, **Administer module missing message
fixer**. Grant it at **People → Permissions** to any role that should be able to
open the fixer form. Administrators typically get it automatically.

## Verify it worked

Go to **Configuration → System → Module Missing Message Fixer**. If your site has
ghost modules you'll see them listed; otherwise you'll see *"No Missing Modules
Found!!!"*. See [Configuration](../configuration/index.md) for how to use it.
