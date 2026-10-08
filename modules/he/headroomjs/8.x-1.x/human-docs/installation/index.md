# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- No other module dependencies.
- The **Headroom.js JavaScript library**, downloaded into your site's `libraries`
  directory (the module does not bundle it). Use module version `8.x-1.0-beta2`
  or later, which matches the library's current file structure.

## Install the module with Composer

From the project root:

```bash
composer require drupal/headroomjs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/headroomjs -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Download the Headroom.js library

The module expects the library at `/libraries/headroomjs` in your docroot:

1. Download the Headroom.js release from GitHub:
   <https://github.com/WickyNilliams/headroom.js>.
2. Unzip it into your docroot's `libraries` directory and rename the folder to
   `headroomjs`.
3. Also download <https://unpkg.com/headroom.js> and place it at
   `/libraries/headroomjs/headroom.js`.

If the files aren't found, the module shows a warning message when you enable it —
so watch for that as your confirmation that the library still needs installing.

## Enable the module

```bash
drush en headroomjs -y
```

## Verify it worked

Log in as an administrator and open **Configuration → System → Headroom.js**
(`/admin/config/system/headroomjs`). If you don't see a warning about missing
library files, the library is in place. Configure the target element and scroll
options as described in [Configuration](../configuration/index.md), then scroll a
long page to confirm the chosen element hides on the way down and reappears on the
way up. Remember to add your own CSS positioning for the effect to look right.
