# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other modules are required, and there are no third‑party Composer or PHP
  library requirements.

> **Choosing a branch:** the 3.1.x branch is the two-panel graph for Drupal 10 and
> 11. If you are on Drupal 11 or 12 and want the newer single-rail renderer,
> configurable branch colours, and provenance base field, use the 4.0.x branch
> instead — see its own guide.

## Install with Composer

From the project root:

```bash
composer require drupal/revision_graph -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/revision_graph -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

To pin the 3.1.x branch specifically:

```bash
composer require "drupal/revision_graph:^3.1" -W
```

## Enable the module

```bash
drush en revision_graph -y
```

## Verify it worked

Open a node that has more than one revision. You should see a **Revision Graph** tab
next to the standard **Revisions** tab; clicking it draws the revision history as a
graph. There is nothing to configure.
