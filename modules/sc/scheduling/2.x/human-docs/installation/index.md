# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core's **Field** module (`field`) and **Datetime Range** module
  (`datetime_range`) — both ship with Drupal core; enable them if they are not
  already on.
- The contrib **[Entity](https://www.drupal.org/project/entity)** API module
  (`entity`).

There are no third-party PHP libraries to install.

> **Optional but recommended:** to let Drupal's core *Page Cache* fully respect
> the max-age of scheduled content, the module's notes point to the core patch
> from issue [#2352009]. The scheduling works without it; the patch just makes
> full-page caching expire exactly on the scheduled second.

## Install with Composer

From the project root:

```bash
composer require drupal/scheduling -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update shared
dependencies, including the Entity API module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/scheduling -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en scheduling -y
```

Drupal will enable the Field, Datetime Range, and Entity dependencies as needed.

## Verify it worked

After enabling, review the **Scheduling** permissions on the People → Permissions
page and grant them to the roles that should be allowed to schedule content. Then
edit a content entity and confirm the date-range scheduling controls are
available.
