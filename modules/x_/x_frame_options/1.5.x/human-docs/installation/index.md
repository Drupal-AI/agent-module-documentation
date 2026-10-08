# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

There are no third-party Composer, PHP library, or Drupal module dependencies.

## Install with Composer

The Composer package is `drupal/x_frame_options` (the project name), even though
the installed module's machine name is `x_frame_options_configuration`. From the
project root:

```bash
composer require drupal/x_frame_options -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/x_frame_options -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it by its **machine name**, `x_frame_options_configuration`:

```bash
drush en x_frame_options_configuration -y
```

There are no submodules.

## Important: save the settings form once

The module ships no default configuration. Until you save the settings form for
the first time, the header falls back to a meaningless `X-Frame-Options: 0`. Go to
**Configuration → System → X-frame-options Configuration**, pick a directive, and
save — see [Configuration](../configuration/index.md).

## Verify it worked

After saving a real directive (for example SAMEORIGIN), check the live header:

```bash
curl -sI https://your-site.example/ | grep -i x-frame-options
```

You should see `X-Frame-Options: SAMEORIGIN` (or whichever directive you chose).
If you chose **ALLOW-ALL**, the header will be absent by design.
