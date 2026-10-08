# Installation

## Requirements

TAPIS Apps needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- **TAPIS Auth** (`tapis_auth`) — and, through it, TAPIS Tenant. Its own
  documentation also expects **TAPIS System** (`tapis_system`) to be present.
- **Webform** (`webform`) and core **Views**.

Composer resolves these dependencies for you. There are no extra PHP or
third-party library requirements. Note this release is a beta (version
1.4.1-beta), so treat it accordingly on production sites.

## Install with Composer

From the project root:

```bash
composer require drupal/tapis_app -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the TAPIS,
Webform, and core dependencies as needed. (The Composer package name,
`drupal/tapis_app`, matches the module's machine name, `tapis_app`.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tapis_app -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tapis_app -y
```

## Verify it worked

With the module enabled you should be able to create **Tapis App** content (Batch,
Web, or VNC), and each user's profile page should show a view listing the apps
they can access. To make an app launchable, continue with **TAPIS App Webform**
and **TAPIS Jobs**.
