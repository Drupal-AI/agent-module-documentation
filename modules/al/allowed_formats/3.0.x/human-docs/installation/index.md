# Installation

## Requirements

Hide format info is lightweight and needs only core modules:

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`). The 3.x
  branch requires 10.1 because it hands the old format‑restriction feature over
  to core, which only gained it in 10.1.
- Core's **Field** (`field`) and **Filter** (`filter`) modules enabled. These
  are part of a standard install, and Drupal enables them automatically as
  dependencies when you turn on this module.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/allowed_formats -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/allowed_formats -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en allowed_formats -y
```

If you are upgrading from the 1.x/2.x branch, run database updates afterward so
the module can migrate your legacy allowed‑formats settings into core's field
setting:

```bash
drush updb -y
```

There are no submodules and no required configuration. Next, head to
[Configuration](../configuration/index.md) to tidy the fields you care about.
