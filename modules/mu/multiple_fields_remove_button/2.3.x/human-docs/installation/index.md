# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- Core's **Field** module (`field`) — part of core and enabled on any site that uses
  fields; pulled in automatically as a dependency.

There are no third-party Composer or PHP library requirements, and no submodules.

## Install with Composer

From the project root:

```bash
composer require drupal/multiple_fields_remove_button -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/multiple_fields_remove_button -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en multiple_fields_remove_button -y
```

That is the entire setup. There is **no settings form, no config to import, and no
per-field configuration**. As soon as the module is enabled, a **Remove** button
appears on every widget row of any supported multi-value field (cardinality other than
1) across your edit forms.

## Verify it worked

Open the edit form of any content that has an unlimited or fixed multi-value field —
for example a node with a multi-value Tags or Link field. Each existing value row
should now show a **Remove** button next to it (with a trash-can icon). Clicking it
deletes that one row over AJAX without touching the others.

If a particular field *doesn't* show the button, its field type or widget may be one
the module intentionally skips (for instance the Media Library widget, which has its
own removal). Adjusting which fields are covered is a developer task using the
module's alter hooks — see the [`agent/`](../agent/start.md) docs.
