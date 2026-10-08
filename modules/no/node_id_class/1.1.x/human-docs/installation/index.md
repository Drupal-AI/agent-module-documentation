# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Node** module (`node`), enabled on any standard Drupal site.

No additional contributed modules and no third‑party libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/node_id_class -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/node_id_class -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_id_class -y
```

## Verify it worked

Edit any content type (**Structure → Content types → *(your type)* → Edit**) and
look for the new **Node ID Class** fieldset. Enter a class or ID using a token —
for example `node-{node_id}-{bundle}` in **CSS Node Class(es)** — save, then view a
node of that type and inspect the markup to confirm the class was rendered. See
"How to use it" on the [overview page](../index.md) for the full field reference.
