# Installation

## Requirements

Field Hidden is deliberately lightweight. It needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Nothing else — there are no third‑party Composer packages, PHP libraries, or
  other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/field_hidden -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_hidden -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_hidden -y
```

That's all it takes. There is no configuration page and no required setup. Once
enabled, the three **"Hidden field"** widgets become available in the **Widget**
drop‑down on any bundle's *Manage form display* page for plain‑text and number
fields. See the [overview](../index.md#how-to-use-it) for how to switch a field to
a hidden widget.
