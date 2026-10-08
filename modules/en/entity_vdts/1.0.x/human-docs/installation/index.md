# Installation

## Requirements

- **Drupal 11.2 or newer, or Drupal 12** (`core_version_requirement:
  ^11.2 || ^12`).
- No module dependencies and no third‑party Composer or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_vdts -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_vdts -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_vdts -y
```

There is no configuration step and no settings page — the new option appears on
each entity's **Manage display** screen.

## Verify it worked

Go to a view display's **Manage display** screen (for example
`/admin/structure/types/manage/page/display`). You should see a new configuration
option for enabling a template suggestion for that display. With Twig debugging
turned on, saving that option and reloading the entity will show the new
suggested template name in the page's HTML comments.
