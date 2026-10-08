# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other contributed modules, PHP extensions, or third‑party libraries are
  required.

Keep in mind this is an experimental proof-of-concept that manipulates the global
autoloader. It is a developer tool — install it in a development or sandbox
environment where you are exploring class-override behavior, and use it in
production only with care.

## Install with Composer

From the project root:

```bash
composer require drupal/crema -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/crema -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en crema -y
```

Enabling Crema on its own does nothing visible. It only acts once another module
declares `class_replacements` in its `info.yml` and depends on Crema — see "How to
use it" on the [overview page](../index.md).

## Verify it worked

Set up a small consuming module with a `class_replacements` declaration and a
replacement class as described in the overview, clear caches, and confirm your
replacement's behavior takes effect where the original class is used. Remember its
limitations: a class can only be replaced once, breakpoints will not work inside the
replaced or replacement file, and the files involved must be under 2 MB.
