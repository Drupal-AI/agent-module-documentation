# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- The **Tarte au citron** module (`tarte_au_citron`) — the consent manager.
- The **Eulerian** module for the tracking being gated (add it as well if it isn't
  already installed).

Composer pulls in the Tarte au citron dependency automatically.

## Install with Composer

From the project root:

```bash
composer require drupal/eulerian_tarte_au_citron -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed and fetch the required `tarte_au_citron` module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/eulerian_tarte_au_citron -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en eulerian_tarte_au_citron -y
```

Drupal will enable `tarte_au_citron` as a dependency. Make sure the **Eulerian**
module is installed and configured too.

## Verify it worked

With Eulerian configured and Tarte au citron set up, load a front‑end page as an
anonymous visitor. Before consent, the Eulerian tracker and its cookies should
**not** be present; after you accept the relevant consent, they should load. Use
your browser's network/console tools to confirm the gating.
