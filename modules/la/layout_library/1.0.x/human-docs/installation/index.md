# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- Core's **Layout Builder** module (`layout_builder`) enabled — this is the only
  dependency, and everything Layout library does builds on it. Drupal enables it
  automatically as a dependency (Layout Builder in turn needs core's Layout Discovery
  module).
- At least one content type (or other entity bundle) with **Layout Builder enabled**
  on a view mode, so there is somewhere to attach the library.

There are no third‑party Composer or PHP library requirements.

> **Beta release.** This is a `1.0.x` beta with an open to‑do list. It is usable but
> not yet production‑hardened — test it against your own workflow first.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_library -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/layout_library -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_library -y
```

There are no sub‑modules. Enabling the module gives you the **Structure → Layout
library** admin screen; from there you create layouts and enable the library on
your bundles. See [Configuration](../configuration/index.md).
