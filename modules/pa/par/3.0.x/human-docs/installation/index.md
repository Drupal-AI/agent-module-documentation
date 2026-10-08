# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No special dependencies — the project notes "No special requirements."

## Install with Composer

From the project root:

```bash
composer require drupal/par -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/par -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en par -y
```

## Set permissions

Personal Access Restriction is driven by permissions, so grant them right after
enabling, at **People → Permissions** (`/admin/people/permissions#module-par`):

- **Configure all Personal Access Restrictions** — needed to reach the overview
  page and the module's top-level admin category.
- **Manage Personal Access Restriction** — lets a user set restrictions on entity
  edit forms.
- **View restricted pages** — a site-wide bypass that lets a role see restricted
  pages anyway. (Users with the `administrator` role always can.)

## Verify it worked

Edit any node and look for the collapsed **Personal Access Restriction** container
on the form — if it's there, the module is active. The restrictions overview lives
at **Configuration → Personal Access Restriction** (`/admin/config/par`). See "How
to use it" in the [overview](../index.md) to create your first restriction — and
note its important limitation: it hides the rendered page only, not the content
everywhere.
