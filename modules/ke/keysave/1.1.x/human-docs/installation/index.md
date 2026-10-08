# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).

That's it — Key Save has no other module dependencies and no third-party
Composer libraries. Its JavaScript relies only on core's `once` library.

## Install with Composer

From the project root:

```bash
composer require drupal/keysave -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/keysave -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en keysave -y
```

## Verify it worked

Open any node, user, or taxonomy term edit form (or a configuration form) and
press **Ctrl-S** / **Cmd-S**. The form should save through its normal *Save*
button instead of triggering the browser's page-save dialog. If nothing happens,
the form may not have a recognized primary submit button — see
[Configuration](../configuration/index.md) to add it to the include list.
