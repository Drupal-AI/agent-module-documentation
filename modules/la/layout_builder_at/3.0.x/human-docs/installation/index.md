# Installation

## Requirements

Layout Builder Asymmetric Translation has no third-party libraries, but it does
build on two core modules:

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Layout Builder** (`layout_builder`) — enabled automatically as a
  dependency.
- Core's **Content Translation** (`content_translation`) — enabled automatically as
  a dependency.

> **Important compatibility note:** this module is **incompatible with Layout
> Builder Symmetric Translations** (`layout_builder_st`). Do not enable both on the
> same site — pick asymmetric (this module) when your languages need genuinely
> different layouts, or symmetric when they should share one structure.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_builder_at -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/layout_builder_at -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_builder_at -y
```

Drupal will pull in Layout Builder and Content Translation if they aren't already
on. There are no submodules.

Enabling the module immediately makes any existing Layout Builder override fields
translatable — but there's no settings form to visit. To actually use it, configure
a content type through the standard *Manage display*, *Content language*, and
*Manage form display* screens as described in the
[overview's "How to set it up"](../index.md#how-to-set-it-up) section.
