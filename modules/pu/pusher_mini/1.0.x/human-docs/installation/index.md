# Installation

## Requirements

- **Drupal 10.1 or newer** (`core_version_requirement: >=10.1`) and **PHP 8.1+**.
- The **[Key](https://www.drupal.org/project/key)** module (`key`) — it is a hard
  dependency and is used to hold your Pusher credentials.
- A **Pusher account** (or a self-hosted, Pusher-compatible server such as
  Soketi) so you have an app id, key, secret, and cluster.
- The server-side **Pusher PHP library** is pulled in automatically when you
  install with Composer — non-Composer installations are not supported.

## Install with Composer

From the project root:

```bash
composer require drupal/pusher_mini -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies, and it brings in the Key module and the Pusher PHP library
automatically.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pusher_mini -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pusher_mini -y
```

This also enables Key if it is not already on.

## Grant permissions

Pusher mini adds three permissions at **People → Permissions**:

- **administer pusher_mini** — access the settings form. Give this to
  administrators only.
- **pusher_mini use** — required for a user to receive the
  `window.PusherConfiguration` script and load the Pusher client. Grant it to
  whichever roles should have the real-time client on the front end.
- **pusher_mini authenticate** — required to call the user-auth endpoint for
  private/user channels. Grant it to roles that need to subscribe to
  user-targeted channels.

## Verify it worked

1. Confirm the module is enabled: `drush pm:list --status=enabled | grep pusher_mini`.
2. Once you have completed [Configuration](../configuration/index.md), load any
   page as a user with **pusher_mini use** and view the page source — you should
   see a `window.PusherConfiguration = {…}` script near the bottom containing your
   (non-secret) app key and cluster.
