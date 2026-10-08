# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- The **Paragraphs** module (`drupal/paragraphs`, `^1.2`) enabled — this is the
  module's dependency, and Composer/Drupal will bring it in for you.

There are no third-party Composer libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_viewmode -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including Paragraphs if it is not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/paragraphs_viewmode -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_viewmode -y
```

If Paragraphs is not already enabled, Drupal enables it as a dependency.

Enabling the module has no visible effect on its own — it simply makes a new
Paragraphs behavior available. To start using it, enable that behavior on a paragraph
type as described in [the overview](../index.md#how-to-use-it).
