# Installation

## Requirements

Decor is deliberately lightweight. It needs:

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).

There are no module dependencies, no third‑party Composer packages, and no
front‑end library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/decor -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/decor -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en decor -y
```

## Verify it worked

Add the `js-decor` class to a container in one of your Twig templates (see "How to
use it" on the [overview page](../index.md)), rebuild the cache
(`drush cr`), and load a page that renders that container. Inspect one of the
images inside it in your browser's developer tools — it should now have `alt=""`,
`role="presentation"`, and no `title` attribute.
