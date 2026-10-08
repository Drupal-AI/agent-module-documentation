# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Views** module (`views`) — enabled by default on most sites.
- The **Twig Tweak** module (`twig_tweak`), used to render the navigation block's
  template. Install it with Composer if it isn't already present.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/next_views_entity_reference -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Twig Tweak and any
shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/next_views_entity_reference -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en next_views_entity_reference -y
```

Drupal will enable Views and Twig Tweak automatically if they aren't on already.

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`), click **Place
block** in any region, and confirm the **Next Views Entity Reference** navigation
block appears in the block browser. Place it, point it at an entity reference View,
then view a node in that View's list — the prior/next links should appear.
Continue with "How to use it" in the [overview](../index.md).
