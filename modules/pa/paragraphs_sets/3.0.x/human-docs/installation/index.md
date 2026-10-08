# Installation

## Requirements

Paragraphs Sets needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Paragraphs** module (`drupal/paragraphs`, `~1.3`) — the contrib module this
  one extends. Composer installs it for you.
- At least one Paragraphs field that uses the **Paragraphs (stable)** widget, since
  that is where the set selector appears. (The legacy
  `entity_reference_paragraphs` widget is not supported.)

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_sets -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Paragraphs
module (if it is not already present) and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraphs_sets -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_sets -y
```

This also enables the Paragraphs module if it is not already on.

## Grant the permission

The module defines one permission, **Administer Paragraphs sets**
(`administer paragraphs sets`), which gates the set-management UI. Grant it to
trusted content architects:

```bash
drush role:perm:add administrator 'administer paragraphs sets'
```

Once enabled, continue to [Configuration](../configuration/index.md) to define your
first set and switch it on for a field.
