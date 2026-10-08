# Installation

## Requirements

- **Drupal 8.9, 9, 10, or 11** (`core_version_requirement: ^8.9 || ^9 || ^10 || ^11`).
- Core's **Image** module (`image`) — enabled automatically as a dependency.
- The **jQuery UI** module (`jquery_ui`) — a contrib dependency that Composer will
  pull in.

## Install with Composer

From the project root:

```bash
composer require drupal/protect_photo -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the jQuery UI
dependency and update any shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/protect_photo -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en protect_photo -y
```

## Verify it worked

Go to the **Manage display** page of a content type that has an image field (for
example `admin/structure/types/manage/page/display`). If **Protect photo Viewer**
appears as a format option for the image field, the module is installed. See "How to
use it" on the [overview page](../index.md) for enabling the deterrent — and remember
its limitations described there.
