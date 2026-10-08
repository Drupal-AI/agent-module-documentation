# Installation

## Requirements

- **Drupal 11 or 12** (`core_version_requirement: ^11 | ^12`).
- No third-party Composer or PHP library requirements, and no other module
  dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/bundle_form -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/bundle_form -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bundle_form -y
```

## Submodule — examples

Bundle form ships one optional submodule, **`bundle_form_examples`**, which
provides ready-made example plugins for node, term, and paragraph bundles. Enable
it to see the pattern in action and copy from it:

```bash
drush en bundle_form_examples -y
```

You don't need the examples submodule in production — once you've written your own
bundle-form plugins, you can leave it disabled.
