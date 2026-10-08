# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- **Composer patching must be enabled** in your root `composer.json`. Config
  Enforce relies on a patch to core and will not work correctly without it.

There are no other module dependencies and no PHP library requirements.

## Enable Composer patching first

Before requiring the module, turn on patching in your project's `composer.json`:

```bash
composer config extra.enable-patching "true"
```

## Install with Composer

From the project root:

```bash
composer require drupal/config_enforce -W
```

Install the development companion **only in your development environment** (the
`--dev` flag keeps it out of production builds):

```bash
composer require --dev drupal/config_enforce_devel
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_enforce -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable Config Enforce everywhere:

```bash
drush en config_enforce -y
```

Enable Config Enforce Devel **only in development** (see its own guide — it must
never be installed in production):

```bash
drush en config_enforce_devel -y
```

## Verify it worked

Once enabled and once you have marked some config as enforced (via the Devel UI),
open the settings form for an enforced config object — it should render as
read-only, confirming enforcement is in effect. If patching was not enabled during
installation, enforcement will not behave correctly; re-check the patching step
above.
