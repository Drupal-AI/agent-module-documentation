# Installation

## Requirements

- **Drupal 8, 9, 10 or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- **Drush 10.3.0 or later** — the module builds on the `drush deploy` command
  that Drush 10 introduced.
- Your project's `composer.json` must route `drupal-module` packages into a
  contrib path via `installer-paths` (a standard Drupal-project setup), for
  example `"web/modules/contrib/{$name}": ["type:drupal-module"]`.

There are no other module dependencies, no PHP library requirements and no
permissions.

## Install with Composer

From the project root:

```bash
composer require drupal/drush_pre_deploy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/drush_pre_deploy -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Register the commands with Drush

The pre-deploy commands live in the module's `src/global` directory, and Drush
must be told to load them. Create a `drush/drush.yml` file at your project root:

```
.
└── ROOT_PROJECT_PATH/
    └── drush/
        └── drush.yml
```

Drush discovers this file automatically. Add the following include so the
`deploy:pre-hook` commands are found:

```yaml
drush:
  include:
    - ${env.PWD}/web/modules/contrib/drush_pre_deploy/src/global
```

Adjust the path if your modules live somewhere other than `web/modules/contrib`.

## Enable the module

The commands themselves work through the Drush include above, but enable the
module so its hook infrastructure is active:

```bash
drush en drush_pre_deploy -y
```

## Verify it worked

Ask Drush for the pre-hook status command — if it's registered, the include is
working:

```bash
drush deploy:pre-hook-status
```

It should list pending pre-deploy hooks (or report none). If Drush doesn't
recognize the command, re-check the path in `drush/drush.yml`.
