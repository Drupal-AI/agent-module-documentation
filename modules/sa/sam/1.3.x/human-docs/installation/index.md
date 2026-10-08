# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).

There are no module dependencies, no third‑party Composer libraries, and no PHP
extension requirements — Simple Add More is pure Drupal.

## Install with Composer

From the project root:

```bash
composer require drupal/sam -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sam -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sam -y
```

That's all that's needed to make it work. The moment it is enabled, any content
form with a supported, fixed‑cardinality (more than one, but not unlimited) field
shows a single empty element and an **"Add another item"** button instead of all
the empty rows. There are no sub‑modules.

If you want to change the button labels or help text, or turn the behaviour off for
a particular widget, see [Configuration](../configuration/index.md).
