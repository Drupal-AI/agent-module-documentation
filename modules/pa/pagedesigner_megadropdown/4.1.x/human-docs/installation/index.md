# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **[Pagedesigner](../../../pagedesigner/4.x/human-docs/index.md)** module
  (`pagedesigner`) — install and enable it first; this add‑on depends on it.

## Install with Composer

From the project root:

```bash
composer require drupal/pagedesigner_megadropdown -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Pagedesigner and any
other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pagedesigner_megadropdown -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pagedesigner_megadropdown -y
```

## Verify it worked

Build a mega‑dropdown panel for a main‑menu item with Pagedesigner, then view your
site's main navigation — hovering or clicking that item should open the multi‑column
mega‑dropdown.
