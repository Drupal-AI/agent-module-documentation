# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **jQuery UI** — used to render the feedback dialog form.
- A **Screenshot API** — used to capture the screenshot that is attached to each
  report. This needs an API key (see [Configuration](../configuration/index.md)).

The jQuery UI and Screenshot API pieces are what power the dialog and the automatic
screenshots; make sure they are available so Radar works fully.

## Install with Composer

From the project root:

```bash
composer require drupal/radar -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/radar -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en radar -y
```

## Verify it worked

After enabling, go to **Structure → Block layout** (`/admin/structure/block`) — you
should be able to place the radar button block. Continue to
[Configuration](../configuration/index.md) to place the button, set up the dialog,
and provide the Screenshot API key.
