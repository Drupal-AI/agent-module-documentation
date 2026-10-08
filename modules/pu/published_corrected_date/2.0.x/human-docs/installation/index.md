# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Node** module (`node`) — part of a standard install and the only
  dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/published_corrected_date -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/published_corrected_date -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en published_corrected_date -y
```

That's all — there's no configuration step. The publication, last‑corrected, and
correction‑count properties begin tracking automatically for nodes going forward.

## Verify it worked

Publish a node (or re‑save an existing published node), then build a simple Views
listing of Content and add the **Publication date** field — it should show the
date the node was first published. Save the node again while it's published and
the **Number of corrections** should increase and the **Last corrected date**
should update.
