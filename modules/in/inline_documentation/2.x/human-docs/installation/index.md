# Installation

## Requirements

Inline Documentation is lightweight and has no third‑party dependencies. It needs:

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- No contributed modules and no external PHP libraries.

On install, the module creates an **Inline Documentation** content type to store
your notes, so you do not need to set that up yourself.

## Install with Composer

From the project root:

```bash
composer require drupal/inline_documentation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/inline_documentation -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en inline_documentation -y
```

## Grant permissions

Go to **People → Permissions** and assign the two permissions this module
provides to the appropriate roles:

- **View inline documentation overview** (`view inline documentation overview`) —
  lets a user open the documentation panel and read notes.
- **Manage inline documentation settings** (`manage inline documentation settings`) —
  lets a user administer the feature.

## Verify it worked

Log in as a user with the view permission and load any page on the site. You
should see a small round blue button in the bottom‑right corner. Click it — the
documentation panel should slide open, ready for you to add your first note. See
the [main guide](../index.md) for the day‑to‑day workflow.
