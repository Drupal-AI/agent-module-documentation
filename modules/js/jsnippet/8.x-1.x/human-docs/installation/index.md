# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- A writable **public file system** — saved snippets are written there and served
  through Drupal's libraries system.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/jsnippet -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/jsnippet -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jsnippet -y
```

## Restrict who can manage snippets

The module provides its own permissions. Because snippets run arbitrary
JavaScript/CSS in visitors' browsers, review these at **People → Permissions**
(`/admin/people/permissions`) right after enabling, and grant them only to fully
trusted administrators and developers — never to general content editors.

## Verify it worked

Create a small test snippet, then add an entity reference to it from a piece of
content and set that field's display to the **Snippet** formatter (see "How to use
it" in the [overview](../index.md)). View the content and confirm your snippet's
code runs on the page — for example, check the browser's JavaScript console or
inspect the page's attached libraries.
