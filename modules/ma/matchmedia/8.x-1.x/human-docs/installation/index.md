# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).

There are no dependencies, third‑party libraries, or PHP requirements — the module
is a self‑contained asset‑library shim.

## Install with Composer

From the project root:

```bash
composer require drupal/matchmedia -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/matchmedia -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en matchmedia -y
```

That is the entire setup — there is no configuration step.

## Verify it worked

After enabling, clear caches (`drush cr`) and reload a page that previously threw a
"matchmedia library not found" error or whose media‑query JavaScript had stopped
working. The error should be gone and the behaviour restored, because the module
now supplies the `matchmedia` library and rewrites dependents to use it. There is
no settings page to check — if the module is enabled, the shim is active.
