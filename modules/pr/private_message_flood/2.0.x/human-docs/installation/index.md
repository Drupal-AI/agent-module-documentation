# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **[Private Message](https://www.drupal.org/project/private_message)** module
  (`private_message`) — this is the messaging system that Private Message Flood
  protects.
- The **[Duration Field](https://www.drupal.org/project/duration_field)** module
  (`duration_field`) — supplies the flexible time-window widget used for the
  limits.

Both dependencies are contributed modules, so Composer needs to fetch them.

> **Note:** the current release line is an alpha (2.0.0-alpha4). Test it on a
> non-production copy before rolling it out.

## Install with Composer

From the project root:

```bash
composer require drupal/private_message_flood -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Private Message
and Duration Field (and any shared dependencies) at compatible versions.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/private_message_flood -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en private_message_flood -y
```

Drupal will enable `private_message` and `duration_field` at the same time if they
aren't already on.

## Verify it worked

Once enabled, configure a low limit for a test role (see
[Configuration](../configuration/index.md)), then log in as a user with that role
and try to exceed it — the module should block further messages until the window
resets.
