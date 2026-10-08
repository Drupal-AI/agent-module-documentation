# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Taxonomy** (`taxonomy`) and **Field** (`field`) modules — both ship with
  Drupal and are enabled automatically as dependencies. You will also want
  **Field UI** enabled to add the field through the admin interface.
- Access to a **self-hosted AGROVOC service** that the module can query for concept
  suggestions. Without a reachable endpoint the field cannot offer suggestions.

There are no third-party PHP libraries to install via Composer.

## Install with Composer

From the project root:

```bash
composer require drupal/agrovocfield -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/agrovocfield -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en agrovocfield -y
```

## Next step

Once enabled, point the module at your AGROVOC endpoint, add the field to a content
type, and review its permissions — see
[How to use it](../index.md#how-to-use-it) on the overview page.
