# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Field** module (`field`) enabled — Drupal enables it automatically as a
  dependency.
- No third-party PHP libraries.

> **Note on maturity:** This is an **alpha** release seeking co-maintainers. It
> currently ships a field type and a list builder and is practically usable only
> with **custom entities**, and only for **small hierarchies** (position updates
> are not batched). Plan accordingly.

## Install with Composer

From the project root:

```bash
composer require drupal/nested_set -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/nested_set -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en nested_set -y
```

## Verify it worked

After enabling, the **Nested Set** field type becomes available when adding a field
to a (custom) entity type. Add one to a custom entity, create a few entities, and
confirm you can arrange them into a hierarchy through the module's list builder.
