# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A reachable **Matomo (Piwik) server** and a Matomo **`token_auth`** credential
  with view access to the site(s) you want to report on.
- **Optional:** the [**Matomo**](https://www.drupal.org/project/matomo) tracking
  module. Matomo Reports does not depend on it, but the **Matomo page statistics**
  block needs it (for the tracked site ID), and if you install it the reports module
  can reuse its configured server URL.

There are no other module dependencies and no third-party PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/matomo_reports -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/matomo_reports -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en matomo_reports -y
```

## Next steps

Point the module at your Matomo server and set a token, then grant the viewing
permission to the roles that should see reports — see
[Configuration](../configuration/index.md).
