# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **RESTful Web Services** module (`rest`) and core's **System** module
  (`system`) — `rest` is a dependency, since the wrapper is intended to talk to
  Drupal's REST resources.

There are no third-party Composer or PHP library requirements. Note the project is
**not covered** by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/restconsumer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/restconsumer -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en restconsumer -y
```

## Use it from your module

Enabling the module makes its JavaScript libraries available, but nothing happens
until your own code uses them. In your module's `*.libraries.yml` (or via
`#attached`), depend on one of:

- `restconsumer/simple` — gives you the global `Restconsumer_Wrapper` class to
  instantiate yourself.
- `restconsumer/restconsumer` — gives you a ready-made, authorized, multilingual
  `Drupal.restconsumer` instance.

Then call the wrapper from your JavaScript as shown in the [main guide](../index.md).

## Verify it worked

`drush pm:list --status=enabled | grep restconsumer` should show the module enabled.
To confirm the library itself, attach `restconsumer/restconsumer` in a small test
and check that `Drupal.restconsumer` is defined in the browser console, then make a
GET call to a REST resource you have exposed and confirm the promise resolves with
the data.
