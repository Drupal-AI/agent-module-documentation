# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Content Translation** module (`content_translation`) enabled — this is a
  required dependency, and Drupal enables it automatically when you turn on Entity
  translations helper.
- A multilingual site (the module's value is in handling entity translations).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_translations_helper -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_translations_helper -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_translations_helper -y
```

## Verify it worked

Because this is a helper module with no settings page, the check depends on which
feature you're after. For the editor‑facing side, create or edit a translatable
node, taxonomy term, or media item and confirm the current‑language notice appears
(on forms without a language selector). For the code helpers, confirm the module is
enabled in **Extend** (`/admin/modules`) and call its utilities from your custom
code.
