# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- Core's **Taxonomy** module (which any site using vocabularies already has enabled).

There are no other module, Composer, or PHP library dependencies. Note that this
project is **not covered by Drupal's security advisory policy**, so review it
accordingly before using it on a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/taxonomy_parent_autocomplete -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/taxonomy_parent_autocomplete -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en taxonomy_parent_autocomplete -y
```

That is the entire setup. There is no configuration form — enabling the module
immediately replaces the parent selector on every taxonomy term form, and its install
step turns on core's `taxonomy.settings:override_selector` so the default selector
steps aside.

## Verify it worked

Edit any taxonomy term (for example `/taxonomy/term/{tid}/edit`). The **Parent terms**
field should now be a type-ahead autocomplete rather than a long dropdown list. On a
big vocabulary, the edit form should also load noticeably faster.
