# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- No other contributed modules, third‑party Composer libraries, or PHP extensions are
  required.

> **Heads up — the Composer package name differs from the module name.** The project
> is `rsvp_list` on Drupal.org (so you `composer require drupal/rsvp_list`), but the
> module's machine name is `rsvplist` (so you `drush en rsvplist`).

## Install with Composer

From the project root:

```bash
composer require drupal/rsvp_list -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rsvp_list -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rsvplist -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → Content authoring → RSVP List**
(`/admin/config/content/rsvplist`). If the settings page loads and lets you pick
content types, the module is installed and ready to configure.
