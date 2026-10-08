# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2||^11`).
- No additional modules, PHP extensions or libraries — Simple AVS is deliberately
  self-contained.

## Install with Composer

From the project root:

```bash
composer require drupal/simpleavs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simpleavs -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simpleavs -y
```

## Verify it worked

Go to **`/admin/config/simpleavs`** to confirm the settings form loads. To see the
gate in action, set the prompt frequency to "On Every Page Load", then open a new
browser window as an anonymous visitor — the age overlay should appear on the front
page by default.

Before you rely on it for anything, please read the limitation in the
[main guide](../index.md): Simple AVS is an advisory prompt, not access control.
