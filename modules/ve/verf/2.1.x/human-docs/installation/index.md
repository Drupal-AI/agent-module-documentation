# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Views** module (`views`) — part of core; enable it if it isn't already.

There are no third-party Composer or PHP library requirements, and no submodules.

## Install with Composer

From the project root:

```bash
composer require drupal/verf -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/verf -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en verf -y
```

That's the entire setup. There's **no settings form, no permissions, and no config to
import**. As soon as the module is enabled, a **"(VERF selector)"** filter becomes
available in the Views UI next to every entity-reference field.

## Next steps

Add the new filter to a view and configure it — see **How to use it** on the
[overview page](../index.md).
