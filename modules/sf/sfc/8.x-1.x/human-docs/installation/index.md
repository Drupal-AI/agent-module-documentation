# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- **PHP 7+** if you define the `LIBRARY` or `DEPENDENCIES` constants in your
  components.
- No other contrib modules, PHP libraries or third-party Composer packages are
  required — the module has no dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/sfc -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sfc -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sfc -y
```

## Submodules — enable only what you need

Single File Components ships two optional submodules. Enable them individually with
`drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **SFC Example** | `sfc_example` | Working example components you can read and copy from — the quickest way to learn the component format. |
| **SFC Dev** | `sfc_dev` | Development helpers for building and iterating on components. |

For example, to add the example components while you learn:

```bash
drush en sfc_example -y
```

## Verify it worked

With the module enabled, visit **`/sfc/library`** as a user who can access it. You
should see the component library page, where components are listed and can be stress-
tested — a good sign the framework is wired up. From there, write your own components
(the `README.md` and the `sfc_example` submodule are the best starting points).
