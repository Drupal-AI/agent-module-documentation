# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Menu Link Content** (`menu_link_content`) module — the only
  dependency. This module does not build on or add features to any other
  contributed module.
- No external PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/codit_menu_tools -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/codit_menu_tools -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en codit_menu_tools -y
```

## Verify it worked

There is no page to visit and nothing to configure — the module simply makes the
`Drupal\codit_menu_tools\MenuManipulator` class available. To confirm it is ready,
use that class from an update hook, a Drush deploy hook, or a script, as shown in
the "How to use it" section of the [guide](../index.md).
