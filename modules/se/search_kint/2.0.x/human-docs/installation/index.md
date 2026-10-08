# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Devel** module (`drupal/devel ^5.1`) — the debugging suite this builds on.
- The **kint-php/kint** library (`^5.0 | ^6.0`) — pulled in as a Composer
  requirement.

This is a **development-only** tool. Devel (and therefore Search kint) should not
be enabled in production.

> **Release status:** the current release is a beta (2.0.0-beta2). Treat it
> accordingly.

## Install with Composer

From the project root:

```bash
composer require drupal/search_kint -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Devel and the
Kint library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_kint -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it only in a development environment:

```bash
drush en search_kint -y
```

Drupal enables Devel as a dependency at the same time.

## Verify it worked

Use Devel's `kint()` to dump a complex variable (a render array or a loaded node).
A search box should appear above the dump, letting you filter the tree and follow
the trail to a matching key.
