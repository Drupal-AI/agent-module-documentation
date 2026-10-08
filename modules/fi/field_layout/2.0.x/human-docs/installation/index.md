# Installation

## Requirements

- **Drupal core newer than 11.3** (`core_version_requirement: >11.3`). This is
  intentional: because Field Layout was a core module up to and including 11.3,
  the contrib version refuses to install on any core that still ships its own
  copy. On core 11.3 or earlier, use the version bundled with core instead.
- Core's **Layout Discovery** module (`layout_discovery`), which provides the
  layout plugins. Drupal enables it automatically as a dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/field_layout -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_layout -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_layout -y
```

> **Migrating from Layout Builder?** Note that most of Field Layout's display
> functionality is also available in core's **Layout Builder**. If Layout Builder
> is enabled when you install Field Layout, the install process can convert
> existing field-layout displays into Layout Builder ones — so consider which of
> the two you want to standardize on before enabling.

## Verify it worked

Go to any bundle's **Structure → Content types → *(type)* → Manage display**. At
the bottom of the screen you should now see a **Layout** selector. Choose a
two-column or three-column layout and the field table will regroup into that
layout's named regions — confirming the module is active. See
[How to use it](../index.md#how-to-use-it) for the full workflow.
