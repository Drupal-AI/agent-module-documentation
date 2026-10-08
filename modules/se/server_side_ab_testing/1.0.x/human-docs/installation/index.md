# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Drupal core's **Node** module (`node`) and **User** module (`user`) — both are
  enabled as dependencies.
- No third-party PHP libraries are required.
- Optional, if you want analytics: a **GA4 / Google Tag Manager** setup on your
  site, since the module exposes experiment data through `drupalSettings` and
  analytics events.

## Install with Composer

From the project root:

```bash
composer require drupal/server_side_ab_testing -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/server_side_ab_testing -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en server_side_ab_testing -y
```

Drupal enables Node and User (core) as dependencies if they are not already on.

## Verify it worked

After enabling, grant the relevant permissions on **People → Permissions** (see
[Configuration](../configuration/index.md)), then create a test experiment with a
Main Page, a Control Page, and at least one Alternative Variant. Set it Active and
visit the Main Page in a fresh browser session — you should be served the control
or a variant, and reloading should keep you on the same one thanks to sticky
assignment.
