# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Node** (`node`) and **Content Moderation** (`content_moderation`)
  modules — both are dependencies. Content Moderation is part of core but not
  enabled by default; Drupal will enable both as needed when you turn this module on.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/clone_enity_revision -W
```

**Note the package spelling.** The Composer package name is
`drupal/clone_enity_revision` (with the transposed "enity"), even though the
module's machine name is `clone_entity_revision`. Use the name exactly as shown
above for Composer.

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/clone_enity_revision -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it by its **machine name**, which does not have the typo:

```bash
drush en clone_entity_revision -y
```

## Grant the permission

The module provides a permission controlling who may clone a revision into a new
node. Assign it to the appropriate editor roles under **People → Permissions**.

## Verify it worked

Open a node with more than one revision, go to its **Revisions** tab, and confirm
the clone action is available for a chosen revision. Using it should create a new
node from that revision's content (with referenced paragraphs deep-cloned and
file/image fields copied independently).
