# Installation

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8 || ^9 || ^10`).
- **Drush** — this `8.x-2.x` line provides its functionality as a Drush command.
  (The older `8.x-1.x` line used Drupal Console instead.)
- **A Direct Queue backend.** The module only supplies the per-item command; you
  need an external daemon to watch the queue and call it. The project provides a
  backend written in Go with releases for most operating systems. Without a backend
  the command still works when invoked manually, but nothing drives the queue
  automatically.

There are no Drupal module dependencies and no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/direct_queue -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/direct_queue -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en direct_queue -y
```

## Verify it worked

Confirm the command is registered:

```bash
drush list | grep direct_queue
```

You should see `direct_queue:run`. To actually process queue items automatically,
set up and run a Direct Queue backend as described on the project page and point it
at your site's database and Drush.
