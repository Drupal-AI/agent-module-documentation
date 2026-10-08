# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Taxonomy** (`taxonomy`) module — it ships with Drupal and is enabled
  automatically as a dependency.

No modules outside Drupal core are required, and there are no PHP library
dependencies.

> **Compatibility note:** Taxonomy Term Preview replaces the default form class
> for taxonomy terms, so it cannot be used alongside another module that also
> overrides the term form. Enable only one such module.

## Install with Composer

From the project root:

```bash
composer require drupal/taxonomy_term_preview -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/taxonomy_term_preview -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en taxonomy_term_preview -y
```

## Verify it worked

Go to **Structure → Taxonomy**, edit any term, and confirm a **Preview** button
now appears next to **Save** on the term form.
