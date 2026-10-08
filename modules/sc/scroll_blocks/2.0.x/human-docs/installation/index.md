# Installation

## Requirements

- **Drupal 8, 9, 10 or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Block** module (`block`) — the only dependency.
- No extra PHP or third-party library requirements. The module is JavaScript, CSS
  and configuration, with no PHP classes.

**Note the release status:** this 2.0.x branch is an **alpha** (2.0.0-alpha7).
Consider that when weighing it for production use.

## Install with Composer

From the project root:

```bash
composer require drupal/scroll_blocks -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/scroll_blocks -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en scroll_blocks -y
```

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`) and configure any
placed block. You should see a new fieldset with the pop-up options (enable pop-up,
reveal and hide scroll distances, and min/max window width). See
[Configuration](../configuration/index.md) for what each option does.
