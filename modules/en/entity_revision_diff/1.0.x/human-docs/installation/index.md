# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The contributed **Diff** (`diff`) module, version **2.0.0-beta4 or newer** —
  this supplies the comparison layouts the module builds on.
- Optionally, the contributed **Group** (`group`) module — enables revision diff
  for Group entities. It is not required unless you use Group.

There are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_revision_diff -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update
dependencies such as the Diff module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_revision_diff -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_revision_diff -y
```

Enable Diff too if it is not already on:

```bash
drush en diff -y
```

## Verify it worked

Open the **Revisions** tab of a supported entity that has more than one revision —
for example a media item at `/media/{id}/revisions`. You should see radio buttons
for selecting two revisions and a way to compare them. If the tab still shows only
a plain list, confirm that both the Diff module and this module are enabled and
that your user has the relevant revision permissions (see the "How to use it"
section of the [overview](../index.md)).
