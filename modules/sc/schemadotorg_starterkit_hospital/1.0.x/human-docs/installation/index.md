# Installation

> **Deprecated project.** This starter kit is deprecated and no longer maintained.
> For new sites, use **Drupal Recipes** instead (see the Schema.org Recipes
> sandbox). The instructions below are for existing or evaluation installations.

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11`).
- **Schema.org Blueprints** (`schemadotorg`) and its starter‑kit component
  (`schemadotorg_starterkit`) — the framework this kit builds on.
- **Paragraphs** (`paragraphs`).
- **Config Rewrite** (`config_rewrite`).
- **Default Content** (`default_content`) — provides the sample content.

Because a starter kit installs content types, fields, mappings, and default content,
it is best run on a **fresh or evaluation site** rather than an established
production site. There are no PHP‑library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/schemadotorg_starterkit_hospital -W
```

The Composer package name (`drupal/schemadotorg_starterkit_hospital`) matches the
module's machine name (`schemadotorg_starterkit_hospital`). The `-W`
(`--with-all-dependencies`) flag lets Composer pull in Schema.org Blueprints,
Paragraphs, Config Rewrite, Default Content, and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/schemadotorg_starterkit_hospital -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en schemadotorg_starterkit_hospital -y
```

Enabling it scaffolds the hospital content types, fields, Schema.org mappings, and
default content in one step.

## Verify it worked

Check **Structure → Content types** (`/admin/structure/types`) for the new
hospital‑related content types, and browse the default content the kit created to
confirm the setup came in.
