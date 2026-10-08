# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- Core's **Path** module (`path`) enabled — the only dependency. Drupal enables
  it automatically as a dependency when you turn on Path Alias Class.

There are no third‑party Composer or PHP library requirements.

> **Heads up:** this project does not have official security‑advisory coverage.
> That's common for small theming helpers, but weigh it before using it on a
> high‑stakes production site.

## Install with Composer

From the project root:

```bash
composer require drupal/path_alias_class -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/path_alias_class -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en path_alias_class -y
```

That's all it takes — the body classes are added immediately.

## Verify it worked

Load any page that has a URL alias and inspect its `<body>` element in your
browser's developer tools. You should see CSS classes derived from the path and
its alias (for example `training` and `node-77`). You can now target those
classes from your theme's stylesheet.
