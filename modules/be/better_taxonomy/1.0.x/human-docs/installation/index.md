# Installation

## Requirements

- **Drupal 10.2, or 11** (`core_version_requirement: ^10.2||^11`).
- Core's **Taxonomy** module (`taxonomy`) — Drupal enables it automatically as a
  dependency when you turn on Better Taxonomy.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/better_taxonomy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/better_taxonomy -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en better_taxonomy -y
```

That's all it takes. The taxonomy improvements are active immediately at
**Structure → Taxonomy**. There is no required configuration.
