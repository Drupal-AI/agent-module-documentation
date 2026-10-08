# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other module dependencies and no third‑party PHP libraries.
- A **local or QA environment only** — this module compiles SCSS and writes CSS to
  the filesystem, and is a developer aid, not a production module.

## Install with Composer

From the project root:

```bash
composer require drupal/browser_development -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/browser_development -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en browser_development -y
```

> **Heads‑up:** as shipped (2.0.0‑beta13), every route in this module is declared
> with `_permission: 'TRUE'` — a permission no role can hold — so all of its pages,
> including the editor and the compile/save API, fail closed and are unreachable
> without a code change. Enable it only on a throwaway development environment, and
> never on production.
