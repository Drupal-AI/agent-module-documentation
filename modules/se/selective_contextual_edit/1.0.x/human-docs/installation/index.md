# Installation

## Requirements

Selective Contextual Edit is lightweight. It needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Contextual Links** module (`contextual`) enabled — this is the only
  dependency, and Drupal enables it automatically when you turn on Selective
  Contextual Edit.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/selective_contextual_edit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/selective_contextual_edit -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en selective_contextual_edit -y
```

## Verify it worked

There is no settings form to visit. To confirm the feature is available, go to
**Structure → Content types → [a content type] → Manage display**, pick a display
mode, and look for the option to enable selective contextual editing on individual
fields. After enabling a field and clearing caches, view a piece of that content
on the front end and hover it — the contextual pencil should open a modal for just
that field.
