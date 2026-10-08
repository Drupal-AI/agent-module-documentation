# Installation

## Requirements

Media Name is lightweight. It needs:

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Media** module (`media`) enabled — the only dependency, enabled
  automatically as a dependency when you turn on Media Name.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_name -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/media_name -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_name -y
```

That's all it takes. Remember the behaviour only applies to media types whose
**Name** field is shown on the form — expose it per type at *Structure → Media
types → (your type) → Manage form display* if it is hidden.

There are no submodules.
