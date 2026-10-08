# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

There are no third-party Composer or PHP library requirements. This is a beta
release (2.0.0-beta7 at the time of writing), so test it before relying on it in
production.

## Install with Composer

From the project root:

```bash
composer require drupal/permanent_entities -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/permanent_entities -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en permanent_entities -y
```

The module provides per-bundle **edit** permissions — review them at
**People → Permissions** (`/admin/people/permissions`) and grant editing of each
permanent entity type only to the roles that should manage that content.

## Verify it worked

Go to **Structure → Permanent Entity Types**
(`/admin/structure/permanent_entity_types`). If the listing page loads, the
module is enabled. Create a type there, then create your first entities from
code or with `drush pec <type> <id> <label>` — see
[How to use it](../index.md#how-to-use-it) in the overview. Confirm that the
entity listing at `/admin/content/permanent_entities` offers no delete or add
action, which is how you know the protection is active.
