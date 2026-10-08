# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core's **Migrate** module (enabled automatically as part of the migration
  stack).
- **Migrate Plus** (`migrate_plus`) — a required dependency, since this plugin
  extends its URL source.
- The environment/hosting must expose environment variables (or Pantheon
  secrets) to PHP so the key can be read at run time. The module was built and
  tested on **DDEV**; other local stacks may behave differently.

There are no extra Composer libraries beyond the modules above.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_api_key -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Migrate Plus and
any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/migrate_api_key -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_api_key -y
```

Drush will enable Migrate Plus (and core Migrate) as dependencies if they aren't
already on.

## Verify it worked

There is no admin page to check. Set the `MIGRATE_API_KEY` environment variable,
point a migration's source plugin at `migrate_api_key_url_plugin` (see
[the module overview](../index.md#how-to-use-it)), run `drush migrate:import`, and
confirm the remote requests are authenticated. If the key is missing you'll see a
warning in **Reports → Recent log messages**.
