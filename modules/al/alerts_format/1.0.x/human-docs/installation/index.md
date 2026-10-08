# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- No third-party Composer or PHP libraries, and no other modules are required.

## Install with Composer

From the project root:

```bash
composer require drupal/alerts_format -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/alerts_format -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en alerts_format -y
```

That is all it takes. The alert styling is available immediately; there is no
required configuration. Note this is a **beta** release (1.0.0-beta1).
