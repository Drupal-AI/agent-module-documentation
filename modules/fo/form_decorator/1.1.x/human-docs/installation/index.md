# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

There are no other module dependencies, no permissions, and no configuration — it
is infrastructure for other modules to build on.

## Install with Composer

From the project root:

```bash
composer require drupal/form_decorator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/form_decorator -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en form_decorator -y
```

## Enable the example submodule (optional)

The project ships a **Form Decorator Example** submodule
(`form_decorator_example`) that demonstrates the decorator pattern with working
classes. It's the fastest way to learn the shape — enable it in a development
environment:

```bash
drush en form_decorator_example -y
```

You would not normally enable the example on a production site; it exists to teach
the pattern.

## Verify it worked

With `form_decorator` enabled, its decorator mechanism is available for your own
modules to use. If you enabled the example submodule, exercise the form(s) it
decorates and confirm the added behaviour appears. From there, write your own
decorator classes in a custom module — see "How to use it" in the
[main guide](../index.md).
