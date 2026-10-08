# Installation

## Requirements

Field Group Link has no third-party libraries, but it builds directly on another
contrib module:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **[Field Group](https://www.drupal.org/project/field_group)** module
  (`field_group`), version **3 or 4** — this is a hard dependency. Composer pulls it
  in automatically.

## Install with Composer

From the project root:

```bash
composer require drupal/field_group_link -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — here it also brings in the Field Group module if it isn't
already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_group_link -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_group_link -y
```

This enables Field Group as well if needed. There are no submodules and no
configuration form.

## Verify it worked

Go to any bundle's **Manage display** screen (for example **Structure → Content
types → Article → Manage display**) and click **Add group**. The format dropdown
should now include **Link** alongside Field Group's other formats. From there, follow
the steps in the [overview](../index.md#how-to-use-it) to build a clickable group.
