# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Node** (`node`) and **Field** (`field`) modules, which are dependencies and
  are part of a standard install.
- No third-party Composer or PHP libraries.

Two things to keep in mind: the release is an **alpha** (`1.0.0-alpha1`) and its
security advisory coverage is **not covered**. Some of its behaviour may also assume
specific content types or fields exist in your project, since it began as an internal
utility.

## Install with Composer

From the project root:

```bash
composer require drupal/pipewrench -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pipewrench -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pipewrench -y
```

## Verify it worked

Pipewrench has no UI of its own, so check its effect: open the edit form for a node
(or configure the Title base field) and confirm that help text can now be set and
appears on the Title field. If it does not, review the module's code against your
project's content types and fields, since its behaviour is tailored to its
maintainers' conventions.
