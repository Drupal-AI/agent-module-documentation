# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Path Alias** module (`path_alias`) — a declared dependency, enabled
  automatically.
- PHP's **cURL** and **DOM** (`DOMDocument`) extensions — the link checker uses
  cURL to test each link and DOM to parse the node's HTML. Both are standard in
  most PHP builds.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/node_link_report -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/node_link_report -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_link_report -y
```

Then grant the **View Node Link Report** permission, place the block, and tune the
settings — see the [main page](../index.md) for the three‑step setup.

## Submodules

None — Node Link Report ships as a single module.
