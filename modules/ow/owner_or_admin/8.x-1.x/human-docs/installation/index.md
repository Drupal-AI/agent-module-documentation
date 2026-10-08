# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- Core's **Views** module (`views`) enabled — this is the only dependency, and it
  is part of a standard Drupal install.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/owner_or_admin -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/owner_or_admin -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en owner_or_admin -y
```

## Verify it worked

Edit any content View at **Structure → Views**, add a **Content: Author**
relationship, then add a filter criterion — the Owner or Admin filter should now
appear in the list of available filters. Add it, save, and view the listing as a
non‑admin user: you should see only your own content, while an administrator sees
everything.
