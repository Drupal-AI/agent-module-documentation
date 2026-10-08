# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Taxonomy** module (part of any site that uses vocabularies).
- No third-party libraries and no other contrib dependencies.

> **Heads up:** this project is not covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/enhanced_taxonomy_form_titles -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/enhanced_taxonomy_form_titles -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en enhanced_taxonomy_form_titles -y
```

That is all — the feature is active immediately, with no configuration.

## Verify it worked

Go to **Structure → Taxonomy** (`/admin/structure/taxonomy`), open a vocabulary,
and add or edit a term. The form's page title should now include the vocabulary
name.
