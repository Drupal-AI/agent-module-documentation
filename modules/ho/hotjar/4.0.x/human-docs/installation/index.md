# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The PHP **json** extension (`ext-json`) — present in virtually every PHP build.
- Core's **Path Alias** module (`path_alias`) — enabled automatically as a
  dependency; the page-visibility rules match both the raw path and its alias.

There are no third-party Composer libraries. You will, of course, need a **Hotjar
account and site ID** to have anything to track with.

## Install with Composer

From the project root:

```bash
composer require drupal/hotjar -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/hotjar -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en hotjar -y
```

## Next steps

The module does not track anyone until you enter your Hotjar ID. Go to
[Configuration](../configuration/index.md), open **Configuration → System → Hotjar**,
enter your ID, and choose which pages and roles to track. Grant the *Administer
Hotjar* permission at `/admin/people/permissions` to whoever manages the settings.

There are no submodules to enable.
