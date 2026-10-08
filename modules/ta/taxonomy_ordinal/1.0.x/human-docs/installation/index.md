# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Taxonomy** module — Drupal enables it automatically as a dependency.

There are no third-party Composer or PHP library requirements. This is a beta
release under active development, so test it on a copy before relying on it in
production.

## Install with Composer

From the project root:

```bash
composer require drupal/taxonomy_ordinal -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/taxonomy_ordinal -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en taxonomy_ordinal -y
```

Enabling the module makes the numbering available, but you still need to switch it
on for the vocabularies you want and add the field before anything shows up. Head to
[Configuration](../configuration/index.md) to finish the setup.
