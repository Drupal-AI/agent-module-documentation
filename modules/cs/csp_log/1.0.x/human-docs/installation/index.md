# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- No hard module dependencies. The module works standalone.
- **Suggested:** the [CSP](https://www.drupal.org/project/csp) module
  (`drupal/csp`). It provides the reporting‑handler plugin type, and installing it
  lets you select the "Dedicated CSP log" handler to wire the report endpoint up
  automatically. It is optional but strongly recommended.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/csp_log -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/csp_log -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

To also install the recommended CSP module:

```bash
composer require drupal/csp -W
```

## Enable the module

```bash
drush en csp_log -y
```

If you are using the CSP module, enable it too (`drush en csp -y`). After
enabling, grant the **Access CSP reports** permission to a trusted role, then wire
the endpoint to your CSP policy as described in the module overview. There is no
settings form to fill in.
