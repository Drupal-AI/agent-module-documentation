# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other module dependencies, and no third‑party Composer or PHP library
  requirements.
- Write access to `sites/default/` is needed for the toggle to create or delete
  `services.yml`.

## Install with Composer

From the project root:

```bash
composer require drupal/twig_debugger -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/twig_debugger -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en twig_debugger -y
```

Enabling the module does not turn debugging on — it just adds the settings form.
Go to **Configuration → Development → Twig Debugger** and tick the box to actually
enable Twig debug mode. See [Configuration](../configuration/index.md).

> **Development only.** Twig debug mode slows rendering and exposes template
> internals, so enable it on local/development environments and remember to turn it
> off again before deploying.

## Verify it worked

Visit `/admin/config/development/twig-debugger` as a user with the **Administer
twig debugger configuration** permission. You should see the **Enable Twig
Debugging** checkbox.
