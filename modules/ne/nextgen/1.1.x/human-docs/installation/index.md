# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- **Drush** — the module's functionality is delivered entirely through Drush's
  code generators (`drush generate`), so a working Drush is required.

There are no module dependencies and no third‑party PHP library requirements. To
make use of the generated output you will, of course, want a Next.js project —
the generators are built around the [DrextJS](https://github.com/cooldrupal/drext)
base.

## Install with Composer

From the project root:

```bash
composer require drupal/nextgen -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/nextgen -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en nextgen -y
```

## Verify it worked

List the available generators and confirm the `nextgen` commands appear:

```bash
drush generate --list
```

You should see `next-entity-component`, `next-view-page`, and `next-jsonapi-page`.
Run any of them to scaffold Next.js code — see "How to use it" in the
[overview](../index.md).
