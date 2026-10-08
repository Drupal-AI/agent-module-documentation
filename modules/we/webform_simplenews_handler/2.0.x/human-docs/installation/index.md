# Installation

## Requirements

Webform Simplenews Handler needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Webform** module (`drupal/webform`) — the forms the handler attaches to.
- The **Simplenews** module (`drupal/simplenews`) — the newsletter system it
  subscribes people to.

Both are required dependencies and must be present for the module to enable. There
are no third-party PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/webform_simplenews_handler -W
```

If Webform and Simplenews aren't already installed, add them too:

```bash
composer require drupal/webform drupal/simplenews -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/webform_simplenews_handler -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en webform_simplenews_handler -y
```

This also enables Webform and Simplenews if they aren't on yet.

## After enabling

1. Create at least one **Simplenews newsletter** (at
   `/admin/config/services/simplenews`) so the handler has something to subscribe
   people to.
2. Edit the webform you want to use, and add the **Submission Newsletter** handler
   — see the [overview](../index.md) for the handler settings.

There is no module configuration page; everything is set per handler on each
webform.
