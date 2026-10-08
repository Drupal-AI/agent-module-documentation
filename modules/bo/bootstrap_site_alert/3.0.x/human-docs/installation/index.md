# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **js_cookie** module (`js_cookie`) — a hard dependency used to remember a
  visitor's dismissal of an alert. Composer pulls it in automatically.
- A **Bootstrap-based theme** for the alert styling to render as intended. The
  module only emits Bootstrap alert classes; a non-Bootstrap theme needs to give
  those classes meaning.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/bootstrap_site_alert -W
```

Composer will also fetch the `js_cookie` dependency. The `-W`
(`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bootstrap_site_alert -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bootstrap_site_alert -y
```

Enabling this also enables `js_cookie` if it is not already on. Next, set the
permissions and create your first alert — see
[Configuration](../configuration/index.md).
