# Installation

> **Deprecated project.** This starter kit is deprecated and no longer maintained.
> For new sites, use **Drupal Recipes** instead (see the Schema.org Recipes
> sandbox). The instructions below are for existing or evaluation installations.

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11`).
- **Schema.org Blueprints** (`schemadotorg`) — the framework this kit builds on.
- **Smart Date** (`smart_date`) — provides the event date fields.
- Core **Views** (`views`).

Because a starter kit installs a content type, views, and default content, it is
best run on a **fresh or evaluation site** rather than an established production
site. There are no PHP‑library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/schemadotorg_starterkit_events -W
```

The Composer package name (`drupal/schemadotorg_starterkit_events`) matches the
module's machine name (`schemadotorg_starterkit_events`). The `-W`
(`--with-all-dependencies`) flag lets Composer pull in Schema.org Blueprints, Smart
Date, and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/schemadotorg_starterkit_events -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en schemadotorg_starterkit_events -y
```

Enabling it scaffolds the Event content type, its fields, Smart Date configuration,
views, and default content in one step.

## Verify it worked

Check **Structure → Content types** (`/admin/structure/types`) for the new **Event**
content type, and look at the front‑end listing views and any default event content
the kit created.
