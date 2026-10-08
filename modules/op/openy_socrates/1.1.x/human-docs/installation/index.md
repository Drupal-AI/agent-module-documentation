# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No module dependencies of its own.
- Part of the [Open Y / YMCA Website Services](https://www.drupal.org/project/openy)
  distribution. It ships an `openy_theme_override` submodule. Outside Open Y the
  module has nothing to do on its own.

## Install with Composer

From the project root:

```bash
composer require drupal/openy_socrates -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/openy_socrates -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en openy_socrates -y
```

On an Open Y site this is normally enabled as a dependency of the modules that use
the `socrates` facade.

## Verify it worked

After enabling, the `socrates` service is available to other modules and to code
(`\Drupal::service('socrates')`). There is no admin page to check — success is that
the module enables cleanly and the components that depend on the facade can resolve
their data providers. If you register a cron provider, remember to add the
`drush ev '\Drupal::service("socrates")->cron();'` crontab entry described in the
overview's "How to use it" section.
