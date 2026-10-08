# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- Core's **Views** module (enabled on most sites by default) — it is the only
  dependency.
- No third-party Composer or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/alpha_numeric_glossary -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/alpha_numeric_glossary -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en alpha_numeric_glossary -y
```

There is no settings page. Once enabled, add the glossary to a View's global area
(header or footer) in the Views UI — see [the overview](../index.md) for the
steps.
