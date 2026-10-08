# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No module dependencies, no third‑party Composer packages, and no external
  library requirements.

## Install with Composer

Drupal Idle Timer is published under the **`dit`** project, so the Composer
package name is `drupal/dit` (not `drupal/drupal_idle_timer`):

```bash
composer require drupal/dit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/dit -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

The module's machine name is `drupal_idle_timer`:

```bash
drush en drupal_idle_timer -y
```

## Verify it worked

After enabling, review the module's settings and set an idle period that suits
your site (see [Configuration](../configuration/index.md)). To test the behavior,
sign in, then leave the browser untouched for longer than the configured idle
period — you should see the warning and/or be logged out. Also check **People →
Permissions** to grant the module's permission to the appropriate roles.
