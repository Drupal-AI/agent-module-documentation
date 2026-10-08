# Installation

## Requirements

- **Drupal 9.3+, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Views** module (`views`) enabled — the only dependency, and Drupal enables it
  automatically.
- No third-party PHP or Composer libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/session_management -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/session_management -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en session_management -y
```

Views is enabled automatically as a dependency. The module ships with defaults (the
session monitor is on, session limit is 1), so review the settings forms next — see
[Configuration](../configuration/index.md).

> **Note on premium features.** This is the free version. Several settings screens
> advertise miniOrange premium/paid options (trial, licensing, support), and the "Delete
> session" action on the per-user sessions list is a premium feature that does nothing
> here.
