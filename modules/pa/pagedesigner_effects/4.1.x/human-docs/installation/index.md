# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **[Pagedesigner](../../../pagedesigner/4.x/human-docs/index.md)** module
  (`pagedesigner`) — install and enable it first; this add‑on depends on it.

## Install with Composer

From the project root:

```bash
composer require drupal/pagedesigner_effects -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Pagedesigner and any
other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pagedesigner_effects -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pagedesigner_effects -y
```

## Set the permission

Because this module ships its own permission for applying effects, visit **People →
Permissions** (`/admin/people/permissions`) after enabling it and grant the relevant
permission to the roles you want to be able to add effects.

## Verify it worked

Edit content that uses Pagedesigner, select an element, and confirm the effects options
this module provides appear in the editor.
