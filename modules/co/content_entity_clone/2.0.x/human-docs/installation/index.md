# Installation

## Requirements

- **Drupal 11.4+ or 12** (`core_version_requirement: ^11.4 || ^12`).
- **PHP 8.5 or newer** (`>=8.5`).
- No modules outside Drupal core are required.
- Works with any content entity type that implements a standard entity **creation
  form**.

## Install with Composer

From the project root:

```bash
composer require drupal/content_entity_clone -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_entity_clone -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_entity_clone -y
```

## Verify it worked

Go to **Configuration → Content Entity Clone** (`/admin/config/content_entity_clone`);
you should see an overview listing your content entity types and their bundles. Enable
cloning for a bundle (for example the Article content type), grant yourself the *Clone
content entities* permission, then open an existing entity of that bundle — a **Clone**
action should appear. Clicking it opens a creation form pre-filled with that entity's
values. See [Configuration](../configuration/index.md) for the full setup.

> **Alternatives:** If this module doesn't fit your needs, related projects include
> [Quick node clone](https://www.drupal.org/project/quick_node_clone),
> [Entity Clone](https://www.drupal.org/project/entity_clone), and
> [Cloner](https://www.drupal.org/project/cloner).
