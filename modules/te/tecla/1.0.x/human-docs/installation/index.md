# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A PHPUnit testing setup — Tecla only does anything during test runs, and refuses
  to run outside a valid test environment.

There are no contributed‑module or external‑library dependencies.

## Install with Composer

Because Tecla is a testing tool, install it as a **development** dependency so it
does not ship to production:

```bash
composer require --dev drupal/tecla -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require --dev drupal/tecla -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable Tecla in the module set your tests run with — for example your test site
profile or CI bootstrap:

```bash
drush en tecla -y
```

There is no configuration to do. Once enabled, the service provider strips the
PSR‑4 mappings of disabled/uninstalled modules from the class loader whenever tests
run.

## Verify it worked

Run a kernel test that relies on a class from a module which is *not* enabled in the
test — with Tecla active, that class should no longer autoload, so the test fails or
errors where previously it may have passed. That is the more realistic behavior
Tecla is designed to produce. On a normal (non‑test) request Tecla stays inert and
will throw if something tries to invoke it outside a test user‑agent.
