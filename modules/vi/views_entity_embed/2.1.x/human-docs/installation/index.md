# Installation

## Requirements

- **Drupal 10.6 or 11.3** (`core_version_requirement: ^10.6 || ^11.3`).
- Core's **Editor**, **Filter**, and **Views** modules (all part of core).
- Two contrib modules, pulled in automatically by Composer:
  - **Embed** (`drupal/embed` `^1.0`)
  - **Entity Embed** (`drupal/entity_embed` `^1.0`)
- A WYSIWYG editor (CKEditor 5) on the text format where you want to embed Views.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/views_entity_embed -W
```

The `-W` (`--with-all-dependencies`) flag is important here: it lets Composer pull
in the required **Embed** and **Entity Embed** modules (and update any shared
dependencies) alongside Views Entity Embed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/views_entity_embed -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it together with its dependencies (Drush will enable the Embed and Entity
Embed modules automatically as requirements):

```bash
drush en views_entity_embed -y
```

There are no submodules. Enabling the module installs a ready-made **Views** embed
button; the remaining setup — turning on the filter, allowing the tag, and placing
the button on your editor toolbar — is done per text format, as described on the
[main page](../index.md).
