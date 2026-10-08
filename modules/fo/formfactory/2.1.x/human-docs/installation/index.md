# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Kits** module (`kits`), which provides the underlying array‑builder
  library Form Factory is built on. Composer pulls it in as a dependency.

There are no third‑party PHP library requirements beyond what Composer resolves.
Note the module does not have security‑advisory coverage.

## Install with Composer

From the project root:

```bash
composer require drupal/formfactory -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it brings in the **Kits** dependency at the same time.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/formfactory -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en formfactory -y
```

To actually build forms you will normally also want the field kits — enable **Form
Factory Kits** as well:

```bash
drush en formfactorykits -y
```

## Verify it worked

There is no admin page to check. Confirm the module is enabled with
`drush pm:list --status=enabled | grep formfactory`, then verify it works by
injecting the Form Factory service in a custom module and building a simple form
(see the example on [the overview page](../index.md)).
