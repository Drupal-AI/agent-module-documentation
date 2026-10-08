# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- The **UI Icons** module (`ui_icons`) — this is a hard dependency, since
  Calimals is an icon pack *for* UI Icons.
- No third-party Composer or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/calimals -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in UI Icons if it is
not already present and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/calimals -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en calimals -y
```

The UI Icons module is enabled automatically as a dependency. Once enabled, the
Calimals icons are available anywhere UI Icons offers an icon picker — there is
nothing else to configure.
