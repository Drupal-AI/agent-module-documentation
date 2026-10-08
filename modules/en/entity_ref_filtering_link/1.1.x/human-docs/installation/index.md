# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other modules are required — it depends only on Drupal core. The **Field UI**
  core module is strongly recommended so you can configure the formatters on
  *Manage display*.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_ref_filtering_link -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_ref_filtering_link -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_ref_filtering_link -y
```

## Verify it worked

Go to the **Manage display** page of a bundle with an entity reference field (for
example **Structure → Content types → Article → Manage display**). Open the
**Format** dropdown for that field — the two filtering‑link formatters this
module provides should now be selectable. Configure the path, argument name, and
mode, save, and confirm the referenced values render as links to your filtered
listing page.
