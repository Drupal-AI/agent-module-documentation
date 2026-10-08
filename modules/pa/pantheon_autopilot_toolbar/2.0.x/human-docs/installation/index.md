# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The site should be **hosted on Pantheon** with Autopilot available — the toolbar
  link is built from a Pantheon environment variable and only resolves there.
- No other Drupal module dependencies. (This is a `2.0.0-beta1` release.)

## Install with Composer

From the project root:

```bash
composer require drupal/pantheon_autopilot_toolbar -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pantheon_autopilot_toolbar -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pantheon_autopilot_toolbar -y
```

## Grant the permission

The button is gated by a module permission. Go to **People → Permissions**
(`/admin/people/permissions`) and grant it to the roles whose members should see
the Autopilot toolbar button.

## Verify it worked

Log in as a user in a role you granted the permission to, on the Pantheon-hosted
environment. An **Autopilot** icon should appear in the admin toolbar, linking to
the site's Autopilot status page on the Pantheon dashboard.
