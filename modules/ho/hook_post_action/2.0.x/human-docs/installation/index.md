# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Nothing else — no module dependencies, no third-party Composer or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/hook_post_action -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/hook_post_action -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en hook_post_action -y
```

There is no configuration. Once enabled, the eight new hooks are available for any
module to implement — see the [How to use it](../index.md#how-to-use-it) section.

## Optional submodule — the example

The project ships **Hook Post Action Example** (`hook_post_action_example`), which
implements every one of the new hooks and logs to a dedicated logger channel on each
event. Enable it to see the hooks firing (and in what order) as a working reference,
then disable it once you have copied what you need:

```bash
drush en hook_post_action_example -y
```

With it enabled, save or delete some content and watch the log at
**Reports → Recent log messages** (`/admin/reports/dblog`) via a normal web request
to see each post-write event recorded.
