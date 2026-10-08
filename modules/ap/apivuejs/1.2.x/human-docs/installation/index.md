# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`). This 1.2.x branch
  targets Drupal 9/10.
- The **`symfony/stopwatch`** library (`^6.2`) — pulled in by Composer with the
  command below.
- A Vue.js front end to consume the JSON endpoints (this module is only the
  backend).

The module also relies on some external `stephane888/*` helper libraries for
building responses; Composer resolves these as dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/apivuejs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in `symfony/stopwatch` and the helper libraries.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/apivuejs -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en apivuejs -y
```

There are no submodules. After enabling, open the settings form and — importantly
— grant the permissions carefully, since the data permission is coarse. See
[Configuration](../configuration/index.md).
