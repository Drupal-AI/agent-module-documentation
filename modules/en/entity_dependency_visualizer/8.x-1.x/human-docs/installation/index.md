# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No third‑party Composer packages or PHP library requirements.

The rendering is powered by Graphviz on the display side; you interact with the
graph in the browser and can optionally export its source for use on the Graphviz
website.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_dependency_visualizer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_dependency_visualizer -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_dependency_visualizer -y
```

Note that this release line is a **beta** (`8.x-1.0-beta1`); test it before relying
on it in production.

## Verify it worked

After enabling, you still need to turn on **Dependency Calculation** manually — see
[Configuration](../configuration/index.md). Once that's done, open any entity and
confirm a **"Content dependencies"** tab appears in its local tasks; clicking it
should render the dependency graph.
