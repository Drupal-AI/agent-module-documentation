# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core **Taxonomy** (`taxonomy`) and **Views** (`views`) — enabled
  automatically as dependencies.

There are no extra PHP libraries to install. To actually change term pages you
will write a small custom module containing an event subscriber (see the main
guide), but nothing extra is needed just to install and enable this module.

## Install with Composer

From the project root:

```bash
composer require drupal/taxonomy_custom_controller -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/taxonomy_custom_controller -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en taxonomy_custom_controller -y
```

There is no configuration step. Note the important consequence described in the
[main guide](../index.md): from now on the term page is built by this module's
controller and event, not by the `taxonomy_term` View — so editing that View no
longer changes the term page.

## Verify it worked

The clean way to confirm the module is working is to enable the bundled
`taxonomy_custom_controller_example` submodule and view a term page affected by
its example subscriber — you should see the customised build. Otherwise, write
your own subscriber to the `TermPageBuildEvent` and confirm your changes appear
on the term page.
