# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Translation Management Tool** module (`tmgmt`).
- Core's **Block** module (`block`).
- **Layout Builder Asymmetric Translation** (`layout_builder_at`).
- **Entity Reference Revisions** (`entity_reference_revisions`).

Composer pulls these dependencies in for you with the command below.

> **Note:** This project is marked as not covered by Drupal's security advisory
> policy and is minimally maintained (maintenance fixes only). Review it before
> using it on a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/tmgmt_asymmetric_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and brings in TMGMT and the Layout Builder dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tmgmt_asymmetric_block -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tmgmt_asymmetric_block -y
```

This also enables the dependencies if they are not already on.

## Verify it worked

Make sure TMGMT is set up with at least one translation provider and your target
languages, and that Layout Builder Asymmetric Translation is enabled for the
entity you are working with. You can then translate Layout Builder blocks through
the TMGMT workflow — each translation produces a new, per-language (asymmetric)
block.
