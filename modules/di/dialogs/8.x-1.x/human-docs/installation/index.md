# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No external PHP or JavaScript library dependencies and no other module
  dependencies.
- Optional: the [Render Filter](https://www.drupal.org/project/renderfilter)
  module if you want to open links that appear inside filtered text.

## Install with Composer

From the project root:

```bash
composer require drupal/dialogs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dialogs -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dialogs -y
```

## Verify it worked

Add a `?dialog=modal` query string to any link on your site — for example a menu
link to `/node/add/page?dialog=modal` — then click it. The target should open in
a modal dialog rather than loading as a full page. If it doesn't, clear the cache
(`drush cr`) and try again.
