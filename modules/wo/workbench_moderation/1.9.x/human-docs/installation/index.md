# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Views** (`views`) and **Options** (`options`) modules, which Drupal
  enables as dependencies.
- Content types (or other bundles) that support **revisions** — enabling
  moderation forces revisions on for a bundle, so the entity type must be
  revisionable (nodes are).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/workbench_moderation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/workbench_moderation -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en workbench_moderation -y
```

Enabling the module installs the four default states (Draft, Needs Review,
Published, Archived) and their transitions, but it does **not** switch moderation
on for any content yet — that is done per content type. Continue to
[Configuration](../configuration/index.md).

> **Considering a new site?** Core **Content Moderation** covers the same ground
> and is the recommended choice for new projects. Use Workbench Moderation when
> you are working with an existing site that already runs it.
