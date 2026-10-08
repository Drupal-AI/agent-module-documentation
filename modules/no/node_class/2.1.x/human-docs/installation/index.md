# Installation

## Requirements

Node class is deliberately tiny. It needs:

- **Drupal 8.9, 9, 10, or 11** (`core_version_requirement: ^8.9 || ^9 || ^10 || ^11`).
- Core's **Node** module (it adds its field to the node entity type). Node is
  enabled on any standard Drupal site.

There are no third-party Composer or PHP library requirements, and the module
declares no dependencies on other contrib modules.

## Install with Composer

From the project root:

```bash
composer require drupal/node_class -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/node_class -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_class -y
```

That's all it takes. The **"CSS class(es)"** field is now present on every
content type immediately — open any node's edit form and look for the collapsible
**Node Class settings** group in the right-hand sidebar. There is no configuration
step and no submodules.
