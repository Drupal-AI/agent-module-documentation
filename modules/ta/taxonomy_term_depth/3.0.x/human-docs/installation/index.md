# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Taxonomy** module (`taxonomy`) — enabled automatically as a dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/taxonomy_term_depth -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/taxonomy_term_depth -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en taxonomy_term_depth -y
```

On enable, the module adds the `depth_level` field to taxonomy terms and **queues
all existing terms for a one-time depth calculation** via a batch. On a large site
this backfill runs through the queue; you can also re-run it per vocabulary later
from the **Update term depths** operation (see the
[overview](../index.md#how-to-use-it)). From then on, depths update automatically
whenever terms are added or moved.

There is no configuration to do after enabling.

## Uninstalling cleanly

Because `depth_level` is a stored base field, Drupal won't let you uninstall the
module while the field still holds data. Clear the values first, then uninstall:

- **Drush:** `drush term-depth-prepare-uninstall` (alias `drush tdpu`) nulls the
  stored depth data.
- **UI:** use the *Delete taxonomy term depths data* form.

Once the data is cleared, uninstall the module the usual way.
