# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **Site Studio templates** (`cohesion_templates`) enabled — this is a hard
  dependency, and it comes as part of Acquia Site Studio.
- **Acquia Site Studio v6.3.5 or newer**, which is where the database
  template-storage feature this module relies on was introduced.
- Realistically, an **Acquia Site Factory** platform — that is the environment
  the module is built for. There is no benefit on other hosting.

There are no additional PHP or third-party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/sitestudio_acsf -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sitestudio_acsf -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sitestudio_acsf -y
```

## Run the required rebuild

Enabling the module switches template storage to the database, but existing
templates still need to be migrated. Run a full Site Studio rebuild:

```bash
drush cohesion:rebuild
```

or use the UI at **/admin/cohesion/developer/rebuild**.

> **Heads-up on database size:** once enabled, database utilisation increases —
> especially during rebuild and sync operations — and your overall database will
> grow, because templates that used to live on disk now live in the database.

## Verify it worked

After the rebuild completes, load a few Site Studio-built pages and confirm they
render with their styling intact. On Site Factory, unstyled output after a
deployment usually points to a compiled-asset path issue, so that is the thing to
check first if anything looks wrong.
