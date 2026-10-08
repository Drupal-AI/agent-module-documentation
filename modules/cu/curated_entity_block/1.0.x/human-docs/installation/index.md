# Installation

## Requirements

- **Drupal 10.3 or newer, or Drupal 11** (`core_version_requirement:
  ^10.3 || ^11`).
- Core's **Views** module (`views`) — the only dependency, and Drupal enables it
  automatically. Views is where you define the selectable pool and allowed view
  modes.
- No third‑party Composer or PHP library requirements.
- **Drupal Canvas** and **Lupus Decoupled / Custom Elements** — *optional*
  integrations the module works well with, not requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/curated_entity_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/curated_entity_block -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en curated_entity_block -y
```

Core's Views module is enabled at the same time as a dependency.

## Verify it worked

After enabling, follow the "Site‑builder setup" section of the project README to
configure a View that defines your curation pool. Then go to **Structure → Block
layout**, place the curated block, and confirm you can hand‑pick and reorder
entities in the block's configuration form.
