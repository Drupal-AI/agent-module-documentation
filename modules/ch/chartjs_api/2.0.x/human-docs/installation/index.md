# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`). This is the only
  requirement — the module has no other module dependencies and no third‑party
  PHP libraries.
- Chart.js itself is loaded from a Cloudflare CDN at runtime, so your visitors'
  browsers need to be able to reach that CDN (worth noting if you run a strict
  Content‑Security‑Policy or an offline/air‑gapped site).

## Install with Composer

From the project root:

```bash
composer require drupal/chartjs_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/chartjs_api -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en chartjs_api -y
```

Or enable **ChartJS API** from **Extend** (`/admin/modules`).

That is all. The `chartjs_api` render element is now available to your code —
there is no configuration page and no submodules. See
[How to use it](../index.md#how-to-use-it) on the overview page for an example
render array.
