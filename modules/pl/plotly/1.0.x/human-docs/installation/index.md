# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core's **Views** module (`views`) — the only dependency, and Drupal enables it
  automatically as a dependency when you turn on Plotly charts views. Views ships
  with core and is enabled on most sites already.
- A working internet connection for site visitors: the charts are drawn with the
  **Plotly.js library loaded from a public CDN**, so that script must be
  reachable from the browser rendering the chart.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/plotly -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/plotly -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en plotly -y
```

## Verify it worked

Go to **Structure → Views** and create or edit a View. In the display's
**Format** setting you should now see **Plotly** listed as an available style.
Select it, configure a couple of fields, and view the result — an interactive
chart you can zoom and pan confirms the module is working.
