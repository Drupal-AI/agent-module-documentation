# Installation

## Requirements

- **Drupal 10.2+ or 11** (`core_version_requirement: ^10.2 || ^11`).

That's it — Route Condition has no other module dependencies and no third-party PHP
libraries. It builds only on core's condition and routing systems.

## Install with Composer

From the project root:

```bash
composer require drupal/route_condition -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/route_condition -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en route_condition -y
```

## Verify it worked

Go to **Structure → Block layout**, place or edit a block, and look for a **Route**
tab under **Visibility**. If it's there, the condition is available. See the
[overview](../index.md#how-to-use-it-block-visibility) for how to write route rules
using wildcards (`*`) and exclusions (`~`).
