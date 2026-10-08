# Installation

## Requirements

Flood Control needs **Drupal 10.2+ or 11**. It has **no other module
dependencies** — it is a lightweight, dependency-free administration helper.

The module works with a mechanism that is already part of Drupal core: the
**flood** system, which blocks login (and other) attempts once a threshold is
reached within a time window. Core normally provides **no user interface** for
those limits — the thresholds live in the `user.flood` configuration object and can
only be changed by editing configuration by hand. Adding that missing UI is exactly
what Flood Control does.

## Install with Composer

From the project root:

```bash
composer require drupal/flood_control -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any related
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/flood_control -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en flood_control -y
```

Once enabled, the settings form appears under **Configuration → People → Flood
control** (`/admin/config/people/flood-control`).

## Verify it worked

Log in as an administrator and go to `/admin/config/people/flood-control`. You
should see the **Flood control** settings page with a **Login** section listing the
IP and username thresholds and their time windows:

![The Flood control settings page after installation](../images/settings.png)

If the page loads and shows the login limits, the module is installed correctly.
Next, review the [configuration guide](../configuration/index.md) to tune the flood
limits and learn how to unblock a locked-out user or IP.
