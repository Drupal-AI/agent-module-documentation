# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Datetime** module (`datetime`), which BrAPI depends on — Drupal enables
  it automatically as a dependency.
- No third-party Composer or PHP library requirements.

Note that the 4.0.x release is a **beta** at the time of writing — test it before
relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/brapi -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/brapi -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en brapi -y
```

This also enables core Datetime if it is not already on. Once enabled, the public
BrAPI pages are available at `/brapi`, and you should configure permissions and
data-type access — see [Configuration](../configuration/index.md).
