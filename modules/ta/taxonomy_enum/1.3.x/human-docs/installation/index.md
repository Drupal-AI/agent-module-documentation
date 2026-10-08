# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3||^10||^11`).
- Core **Taxonomy** module (`taxonomy`).
- **Taxonomy Machine Name** (`taxonomy_machine_name`) — this module lines terms
  up with enum cases by their machine names, so it is required.

There are no extra PHP libraries to install. Using the module meaningfully
assumes you are comfortable defining PHP enums and writing a little custom code.

## Install with Composer

From the project root:

```bash
composer require drupal/taxonomy_enum -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Taxonomy
Machine Name module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/taxonomy_enum -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en taxonomy_enum -y
```

Enabling Taxonomy Enum also enables Taxonomy Machine Name if it is not already
on.

## Verify it worked

Both **Taxonomy Enum** and **Taxonomy Machine Name** should show as enabled at
**Extend** (`/admin/modules`). From there the module is used from code — define
an enum, connect it to a vocabulary, and confirm the terms are created from the
enum's cases as described in the [main guide](../index.md).
