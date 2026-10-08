# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Block** module (`block`) — the only dependency, and Drupal enables it
  automatically when you turn on Local Task Splitter.

### Recommended

- **UI Icons** — highly recommended if you want to add intuitive icons to your
  task dropbuttons.

This is a **1.0.1** release; note the project is minimally maintained.

## Install with Composer

From the project root:

```bash
composer require drupal/local_task_splitter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/local_task_splitter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en local_task_splitter -y
```

## Verify it worked

Go to **Configuration → User interface → Local Task Split**
(`/admin/structure/local_task_splits`) and confirm you can create a new split
configuration. Then head to [Configuration](../configuration/index.md) to define a
split and place its block.
