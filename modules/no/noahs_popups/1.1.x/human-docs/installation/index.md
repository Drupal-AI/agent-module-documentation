# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **[Noahs Page Builder](https://www.drupal.org/project/noahs)**
  (`noahs_page_builder`) — this is a required dependency; Noahs Popups is an
  add-on to it. Composer installs it for you with the `-W` flag.
- No third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/noahs_popups -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Noahs Page
Builder (and its own core-module dependencies) and update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/noahs_popups -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en noahs_popups -y
```

Drupal enables Noahs Page Builder at the same time if it isn't already on.

## Grant the permission

Popup building reuses Noahs Page Builder's **Administer Noahs** permission
(`administer noahs_page_builder`). Grant it only to fully trusted roles at
**People → Permissions** — as with the base builder, it allows arbitrary
HTML/CSS content.

## Verify it worked

As a user with **Administer Noahs**, go to
`/admin/structure/noahs/create-popup` and confirm the popup builder opens, then
check the list at `/admin/structure/noahs/popup-list`. Build a simple popup, set
it active, and load a front-end page that matches its display conditions to see
it appear.
