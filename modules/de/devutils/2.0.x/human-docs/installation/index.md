# Installation

## Requirements

DevUtils is lightweight and has no third‑party requirements:

- **Drupal 11** (`core_version_requirement: ^11`).
- No other module dependencies and no external PHP or JavaScript libraries.

Because it is a developer aid, install it in your **development and staging
environments** — not on production.

## Install with Composer

From the project root:

```bash
composer require drupal/devutils -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/devutils -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en devutils -y
```

## Verify it worked

Once enabled, DevUtils' helpers are available to your development workflow. See
the module's README for how to invoke each utility — for example listing entity
UUIDs, cleaning unused files, or importing module configuration from an update
hook. Remember to keep this module disabled on production.
