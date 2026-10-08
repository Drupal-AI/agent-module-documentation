# Installation

## Requirements

- **Drupal 10 or newer** (`core_version_requirement: >=10`).
- No other modules, and no third-party Composer or PHP libraries. It simply uses
  whatever theme you've configured as the site's admin theme.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_theme_switch -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. (The Composer package name, `drupal/simple_theme_switch`,
matches the module's machine name.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_theme_switch -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_theme_switch -y
```

## Set your admin theme

The module renders the account pages in whatever theme is set as your **admin
theme**. Confirm your choice at **Appearance** (`/admin/appearance`) — the login,
password-request, and password-reset pages will use it. There is no settings form
for the module itself.

## Verify it worked

Log out and visit `/user/login` (or `/user/password`). The page should now be
styled with your admin theme rather than the front-end theme.
