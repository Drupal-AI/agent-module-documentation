# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Comment** module (`comment`) — enabled automatically as a dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ajax_comments -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ajax_comments -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ajax_comments -y
```

There are no submodules. AJAX behavior is enabled by default on every comment
field, so commenting becomes AJAX-driven as soon as the module is on.

## Verify it worked

Open a page with a comment thread and post or reply to a comment — the thread
should update in place without a full page reload. If you want to change the
site-wide behavior or turn AJAX off on specific fields, see
[Configuration](../configuration/index.md).
