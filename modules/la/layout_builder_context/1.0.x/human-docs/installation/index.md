# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Layout Builder** module (`layout_builder`).
- The contributed **Context** module
  ([`context`](https://www.drupal.org/project/context)) — this module builds
  directly on Context's condition system.

Drupal will enable Layout Builder as a dependency automatically. Context is a
separate contributed project, so install it with Composer alongside this module
(see below).

## Install with Composer

From the project root:

```bash
composer require drupal/layout_builder_context -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Context
module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/layout_builder_context -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_builder_context -y
```

This enables Layout Builder and Context as dependencies if they are not already
on.

## Verify it worked

Build a Context at **Structure → Context**, then open a Layout Builder layout and
configure a section or a block. You should see a **Context visibility** option
letting you pick the Context you created. If it appears, the module is working.
