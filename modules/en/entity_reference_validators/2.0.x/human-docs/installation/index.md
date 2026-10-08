# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's entity reference field support (part of Drupal core). There are no other
  module dependencies and no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_reference_validators -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_reference_validators -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_reference_validators -y
```

Enabling the module adds nothing visible on its own — the checks are opt-in per
field. Open any entity reference field's edit form and use the new **Reference
validators** section, as described in the *How to use it* section on the
[overview page](../index.md).
