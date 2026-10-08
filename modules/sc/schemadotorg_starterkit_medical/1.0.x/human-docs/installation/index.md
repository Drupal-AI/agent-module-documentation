# Installation

> **Deprecated project.** This starter kit is deprecated and no longer maintained.
> For new sites, use **Drupal Recipes** instead (see the Schema.org Recipes
> sandbox). The instructions below are for existing or evaluation installations.

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11`).
- **Schema.org Blueprints** (`schemadotorg`) and its starter‑kit component
  (`schemadotorg_starterkit`), along with several Blueprints submodules — the
  framework this kit builds on.
- Core **Views** (`views`).
- Core **Menu UI** (`menu_ui`).

Because a starter kit installs content types, views, mappings, and default content,
it is best run on a **fresh or evaluation site** rather than an established
production site. There are no PHP‑library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/schemadotorg_starterkit_medical -W
```

The Composer package name (`drupal/schemadotorg_starterkit_medical`) matches the
module's machine name (`schemadotorg_starterkit_medical`). The `-W`
(`--with-all-dependencies`) flag lets Composer pull in Schema.org Blueprints and any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/schemadotorg_starterkit_medical -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en schemadotorg_starterkit_medical -y
```

Enabling it scaffolds the medical content types (mapped to Schema.org
`MedicalEntity`), views, and default content in one step.

## Verify it worked

Check **Structure → Content types** (`/admin/structure/types`) for the new
medical‑related content types (conditions, procedures, physicians, and so on),
review the listing views, and browse the default content the kit created.
