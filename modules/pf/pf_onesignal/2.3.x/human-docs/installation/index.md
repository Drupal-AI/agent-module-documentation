# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **[Push Framework](https://www.drupal.org/project/push_framework)** module
  (`push_framework`) — this is the base system that pf_onesignal plugs into.
- Core's **User** module (`user`), which is enabled on every standard site.
- A **OneSignal account** with an app set up, plus a native mobile app that
  integrates the OneSignal SDK to register devices.

There are no extra Composer libraries to add by hand.

## Install with Composer

From the project root:

```bash
composer require drupal/pf_onesignal -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Push Framework
module and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pf_onesignal -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pf_onesignal -y
```

Drupal enables Push Framework automatically as a dependency if it is not already on.

## Verify it worked

Log in as an administrator and go to **Configuration → System → Push Framework →
OneSignal** (`/admin/config/system/push_framework/onesignal`). If the settings
form loads, the module is installed. Nothing is delivered yet — head to
[Configuration](../configuration/index.md) to enter your OneSignal credentials, and
enable the OneSignal channel within Push Framework's own settings.
