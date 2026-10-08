# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **Kits** module (`kits`) — the underlying array‑builder library.
- The **Form Factory** module (`formfactory`) — the superstructure the kits are
  appended to.

Composer resolves both Drupal dependencies for you. There are no third‑party PHP
library requirements beyond that, and the module does not have security‑advisory
coverage.

## Install with Composer

From the project root:

```bash
composer require drupal/formfactorykits -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it brings in **Kits** and **Form Factory** at the same
time.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/formfactorykits -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en formfactorykits -y
```

This also enables **Form Factory** and **Kits** if they aren't already on.

## Verify it worked

There is no admin page to check. Confirm the module and its dependencies are
enabled with `drush pm:list --status=enabled | grep -E 'formfactory|kits'`, then
verify it works by injecting the `FormFactoryKits` service in a custom module and
building a form from kits (see the example on [the overview page](../index.md)).
