# Installation

## Requirements

This starter kit needs:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Schema.org Blueprints** starter-kit submodule (`schemadotorg_starterkit`)
  and the wider Schema.org Blueprints suite.
- Core's **Views** (`views`), **Config Rewrite** (`config_rewrite`) and **Default
  Content** (`default_content`).

Installing with Composer pulls these projects in as dependencies; Drupal enables
the required modules when you turn the starter kit on. There are no extra PHP or
third-party library requirements.

Because a starter kit installs configuration into the site, run it on a **fresh or
evaluation site** rather than an established production site.

## Install with Composer

From the project root:

```bash
composer require drupal/schemadotorg_starterkit_recipes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/schemadotorg_starterkit_recipes -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en schemadotorg_starterkit_recipes -y
```

Enabling it scaffolds the Recipe content type, its Schema.org mapping, the Recipes
view and the default content.

## Verify it worked

Go to **Structure → Content types** and confirm the **Recipe** type is present
with fields for ingredients, steps and times. Visit the **Recipes** listing view
and check that the default example recipes appear.
