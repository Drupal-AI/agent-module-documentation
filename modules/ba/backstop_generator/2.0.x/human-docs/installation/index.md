# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Breakpoint** module — the generator reads your breakpoints to build
  the screenshot viewports. Drupal enables it automatically as a dependency.
- **BackstopJS itself** runs outside Drupal (a Node.js tool). This module only
  produces the `backstop.json` config; you run BackstopJS separately against
  that file to capture and compare screenshots.

There are no third-party Composer or PHP library requirements for the Drupal
module.

## Install with Composer

From the project root:

```bash
composer require drupal/backstop_generator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/backstop_generator -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en backstop_generator -y
```

After enabling, grant the module's permission to your developer/administrator
role, then head to [Configuration](../configuration/index.md) to set up your
scenarios and generate the file.
