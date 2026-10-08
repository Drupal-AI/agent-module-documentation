# Installation

## Requirements

Reference Value Pair needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Field** module (`field`) enabled — this is the only dependency, and it
  is part of a standard Drupal install.

There are no third‑party Composer or PHP library requirements. The optional Feeds
integration only applies if you also use the contributed **Feeds** module.

## Install with Composer

From the project root:

```bash
composer require drupal/reference_value_pair -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/reference_value_pair -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en reference_value_pair -y
```

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage fields** and click
**Create a new field**. The field-type list should now include **Reference Value
Pair**. Add it to a bundle and confirm the edit form shows both a reference
selector and a value input. See the parent
[guide](../index.md#how-to-use-it) for the full field setup walkthrough.
