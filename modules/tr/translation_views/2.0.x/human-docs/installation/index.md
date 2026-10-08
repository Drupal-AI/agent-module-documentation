# Installation

## Requirements

Translation Views builds on core's multilingual and Views systems:

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Content Translation** module (`content_translation`), enabled.
- Core's **Views** module (`views`), enabled (part of the standard install).
- At least one entity type that is **translatable and has content translation enabled** —
  the module's fields and filters only appear for such entity types.

There are no third‑party Composer packages or PHP extensions to install. (The project
*suggests* `drupal/translators_content` for translator‑oriented content integration, but
it is optional and only used in development.)

## Install with Composer

From the project root:

```bash
composer require drupal/translation_views -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/translation_views -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en translation_views -y
```

This pulls in **Content Translation** and **Views** if they aren't already on. Or enable
**Translation Views** from **Extend** (`/admin/modules`).

There are no submodules and no configuration form.

## Next steps

Before the translation fields appear in Views, make sure content translation is enabled
for the entity type you want to report on (at **Configuration → Regional and language →
Content language and translation**). Then build a view and add the Target language filter
— see [How to use it](../index.md#how-to-use-it) on the overview page. The bundled demo
view is at `/translate/content`.
