# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Drupal **core only** — there are no other module, Composer, or PHP library
  dependencies. (Webform is listed as a development dependency, meaning Webform
  integration is exercised in the module's tests, but Webform is not required to
  use the element.)

## Install with Composer

From the project root:

```bash
composer require drupal/datalist -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/datalist -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en datalist -y
```

## Verify it worked

There is no admin page to check — the module simply makes the `datalist` render
element and form widget available. To confirm it's working, add a `datalist`
element to a custom form (or a Datalist element to a Webform) as shown in the
["How to use it"](../index.md#how-to-use-it) section, then load the form: as you
type into the field, the browser should offer your suggestions while still
allowing free text.
