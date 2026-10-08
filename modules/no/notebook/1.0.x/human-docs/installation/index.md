# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- No third‑party Composer or PHP library requirements, and no other module
  dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/notebook -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/notebook -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en notebook -y
drush cr
```

Clearing caches after enabling is what makes the **Notebook** link appear in the
admin menu.

## Grant the permission

The notebook is admin‑only. Grant **administer notebook** to the roles that should
use it:

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Tick **administer notebook** for your trusted staff roles only — remember every
   holder of this permission shares the same notebook and can edit or delete any
   note.
3. Click **Save permissions**.

## Verify it worked

As a user with the *administer notebook* permission, open the **Notebook** link in
the admin menu (or visit `notebook/page`). You should see the add‑note form and an
(initially empty) list of notes. Add a test note to confirm it saves and appears in
the list.
