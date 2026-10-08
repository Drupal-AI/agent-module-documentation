# Installation

## Requirements

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`).

That is all. Replicate depends only on Drupal core — there are no other module
dependencies and no third‑party Composer or PHP library requirements. Core entity
types such as nodes, taxonomy terms, comments and files can be cloned out of the
box; the Layout Builder integration activates automatically only when core's Layout
Builder module is enabled.

## Install with Composer

From the project root:

```bash
composer require drupal/replicate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/replicate -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en replicate -y
```

## No configuration or permissions

Replicate has no settings form and defines no permissions, so there is nothing to
configure after enabling it. It simply makes the `replicate.replicator` service
available for your own code (or another module) to use — see the
[overview](../index.md) and the sibling [`agent/`](../agent/start.md) docs for how
to call it.

## Verify it worked

Confirm the module is enabled (for example
`drush pm:list --status=enabled | grep replicate`). From then on the
`replicate.replicator` service is available in the container for cloning entities in
code.
