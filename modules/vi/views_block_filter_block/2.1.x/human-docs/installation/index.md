# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Views** module (`views`), enabled.
- The **CTools Views** submodule (`ctools:ctools_views`) — the module builds on
  it, and Composer/Drupal pull in CTools as a dependency.

There are no other third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/views_block_filter_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in the CTools dependency.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/views_block_filter_block -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_block_filter_block -y
```

This also enables the required **CTools Views** submodule if it is not already
on. There is no configuration form and no permission to grant — installing the
module *is* the whole setup.

## Verify it worked

Edit a view that has a **Block** display at **Structure → Views**, select the
block display, and open its **Advanced** options. You should now see an **Exposed
form in block** option (set to *No* by default). Setting it to *Yes* is how you
use the module — see the [overview](../index.md#how-to-use-it) for the full
workflow.
