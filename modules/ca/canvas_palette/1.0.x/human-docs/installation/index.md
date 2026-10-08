# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Canvas** module (`drupal/canvas`) — the Experience Builder page builder.
- Core **Image** (`image`) and **Views** (`views`) modules.
- The **Webform** module (`drupal/webform`), for the webform‑integrated
  components.

## Install with Composer

From the project root:

```bash
composer require drupal/canvas_palette -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update shared
dependencies (including Canvas and Webform if they are not already present).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/canvas_palette -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en canvas_palette -y
```

Enabling it pulls in Canvas, Image, Views, and Webform as dependencies if they
are not already on. Afterwards, review the permission the module declares at
**People → Permissions** (`/admin/people/permissions`) and grant it to the roles
that should use the palette components.
