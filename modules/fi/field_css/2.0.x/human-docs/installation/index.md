# Installation

## Requirements

- **Drupal 8.8.4, 9, 10, or 11** (`core_version_requirement: ^8.8.4 || ^9 || ^10 ||
  ^11`).
- Core's **Field** module (`field`) — part of core, enabled as a dependency.
- The **CodeMirror Editor** module
  ([`codemirror_editor`](https://www.drupal.org/project/codemirror_editor)) — used
  for the CSS editing experience / syntax highlighting. Composer pulls it in for
  you.

## Install with Composer

From the project root:

```bash
composer require drupal/field_css -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and brings in CodeMirror Editor.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_css -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_css -y
```

This also enables CodeMirror Editor if it is not already on.

## Verify it worked

Go to any bundle's **Manage fields**, click **Add field**, and a **CSS** field type
should be available. Remember to grant the **`access css fields`** permission to
trusted roles before anyone can enter CSS — see the
[overview](../index.md#how-to-use-it).
