# Installation

## Requirements

- **Drupal 10, or Drupal 11.3 and newer** (`core_version_requirement:
  ^10 || ^11.3`).
- Core's **Layout Builder** (`layout_builder`) module, enabled automatically as a
  dependency.

There are no third‑party Composer or PHP library requirements. The module
provides no permissions or configuration.

## Install with Composer

From the project root:

```bash
composer require drupal/tempstore_plus -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. The Composer package name (`drupal/tempstore_plus`)
matches the module's machine name (`tempstore_plus`).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tempstore_plus -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

Note that you will often not install this module directly — it commonly arrives
automatically as a dependency of the **Navigation +** (`navigation_plus`) or
**Layout Builder +** (`lb_plus`) editing stack.

## Enable the module

```bash
drush en tempstore_plus -y
```

There is nothing to configure. Once enabled, the module works as infrastructure
behind the scenes. If you notice tempstore behaviour change after installing the
`lb_plus` stack, this is the module responsible — it alters container services on
install.
