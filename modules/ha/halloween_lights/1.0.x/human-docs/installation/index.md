# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other module dependencies.

There are no third-party Composer or PHP library requirements.

> **Note:** this module is **not covered by Drupal's security advisory policy**.
> It's purely cosmetic, but that's worth knowing before adding it to production.

## Install with Composer

From the project root:

```bash
composer require drupal/halloween_lights -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/halloween_lights -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en halloween_lights -y
```

That's all — the decoration is active immediately.

## Verify it worked

Visit any non-admin page of your site. A string of glowing Jack-o'-lantern lights
should appear at the top, with the pumpkins flickering at random. When the season
ends, disable the module (`drush pmu halloween_lights -y`) to remove the lights.
