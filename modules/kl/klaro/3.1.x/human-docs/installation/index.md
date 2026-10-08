# Installation

## Requirements

- **Drupal 10.2 or newer, or Drupal 11** (`core_version_requirement:
  ^10.2 || ^11`).
- The **Klaro! JavaScript library** package (`drupal/klaro_js` `~3.1.0`), which
  Composer pulls in for you. This is the actual Klaro! front-end library the
  module wraps.

There are no other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/klaro -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it brings in the required `drupal/klaro_js` library
package at the same time.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/klaro -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en klaro -y
```

The consent banner is active on the front end as soon as the module is enabled,
using the bundled default services and purposes. Head to
[Configuration](../configuration/index.md) to enable the services that match your
site and tune the wording and behavior.

There are no submodules. A **Google Consent Mode** recipe ships in the module's
`recipes/` folder — apply it separately if you use Google's consent-mode signals.
