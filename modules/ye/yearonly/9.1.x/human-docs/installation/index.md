# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Field** and **Field UI** modules (part of core) so you can add and
  manage fields through the UI.

There are no third‑party Composer packages or other module dependencies. The
**Feeds** module (`drupal/feeds`) is *suggested* — install it only if you want to
map a year‑only field as a target in a Feeds import; it is not required for normal
use.

## Install with Composer

From the project root:

```bash
composer require drupal/yearonly -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/yearonly -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en yearonly -y
```

Once enabled, the **Year Only** field type is available whenever you add a field.
See [How to use it](../index.md#how-to-use-it) on the overview page for the
field‑by‑field setup.

There are no submodules.
