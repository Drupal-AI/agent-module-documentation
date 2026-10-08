# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core **System** (`system`).
- **[Migrate Tools](https://www.drupal.org/project/migrate_tools)** (`migrate_tools`)
  and **[Migrate Plus](https://www.drupal.org/project/migrate_plus)** (`migrate_plus`)
  — the Migrate stack the demo content is imported through.
- **[YAML Editor](https://www.drupal.org/project/yaml_editor)** (`yaml_editor`) — for
  editing the migration configuration.
- A working **[CML Starter](https://www.drupal.org/project/cmlstarter)** shop to
  import the demo content into.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/cmlstarter_demo -W
```

The `-W` (`--with-all-dependencies`) flag brings in the Migrate and YAML Editor
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cmlstarter_demo -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cmlstarter_demo -y
```

The Migrate and YAML Editor dependencies are enabled automatically if they aren't
already.

## Verify it worked

After enabling, run the bundled migrations (via Migrate Tools) and confirm the demo
products and catalog content appear in your store. This module is for demo/evaluation
use — don't enable it on a production site.
