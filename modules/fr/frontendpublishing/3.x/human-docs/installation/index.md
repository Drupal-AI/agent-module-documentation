# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **RestConsumer** module (`restconsumer`) — a required dependency.
- Core's **HAL** module (`hal`) — a required dependency.

Because the workflow is driven over REST/AJAX, these dependencies provide the
request-handling layer the module relies on. Composer will pull in what it can, but
note that `restconsumer` is itself a contributed project.

## Install with Composer

From the project root:

```bash
composer require drupal/frontendpublishing -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/frontendpublishing -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en frontendpublishing -y
```

Drupal will enable the `restconsumer` and `hal` dependencies at the same time.

## Submodules

- **Frontend Publishing Scheduler** (`frontendpublishing_scheduler`) — adds
  time-based (scheduled) publishing to the front-end workflow. Enable it only if you
  need scheduling:

  ```bash
  drush en frontendpublishing_scheduler -y
  ```

## Verify it worked

Confirm the module is enabled with `drush pm:list --status=enabled | grep
frontendpublishing`. There is no admin settings page to visit — the next step is
wiring the module's JavaScript interface and REST endpoints into your front end, and
verifying that every publish/edit/schedule action is access-checked against the
user's real permissions.
