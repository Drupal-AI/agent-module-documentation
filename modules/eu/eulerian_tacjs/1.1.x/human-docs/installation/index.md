# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1||^11`).
- The **Eulerian** module (`eulerian`) — provides the tracking being gated.
- The **TacJS** module (`tacjs`) — the consent‑managed tag loader.

Composer pulls in both dependency modules automatically.

## Install with Composer

From the project root:

```bash
composer require drupal/eulerian_tacjs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed and fetch the required `eulerian` and `tacjs` modules.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/eulerian_tacjs -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en eulerian_tacjs -y
```

Drupal will enable `eulerian` and `tacjs` as dependencies.

## Verify it worked

With Eulerian configured and TacJS set up, load a front‑end page as an anonymous
visitor. Before consent, the Eulerian tag should **not** load; after you accept the
relevant consent category, it should load. Check your browser's network/console
tools or page source to confirm the gating.
