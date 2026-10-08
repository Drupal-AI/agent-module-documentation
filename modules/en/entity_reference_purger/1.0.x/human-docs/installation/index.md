# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No third-party libraries and no other module dependencies. It works with core's
  entity reference fields, which are available on standard installs.
- If you plan to use the **Use queue** option, make sure **cron** runs regularly,
  since queued purges are processed on cron.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_reference_purger -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_reference_purger -W`, `ddev
> drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_reference_purger -y
```

There are no submodules.

## Next step

The module does nothing until you turn it on for a specific entity reference
field. See the module [overview](../index.md#how-to-use-it) for how to enable
purging on a field.
