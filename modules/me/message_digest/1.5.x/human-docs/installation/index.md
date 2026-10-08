# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Message Notify** module (`message_notify`) — Message Digest plugs into
  its notifier system. Drupal enables it as a dependency.
- The **Message Subscribe** module (`drupal/message_subscribe`, `^1.0 || ^2.0`),
  which is a Composer requirement and is pulled in automatically. This in turn
  brings in the base Message framework.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/message_digest -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Message Notify,
Message Subscribe, and the rest of the Message stack, and update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/message_digest -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en message_digest -y
```

## Submodule — Message Digest UI

An optional submodule, **Message Digest UI** (`message_digest_ui`), adds a
per-user notification-frequency field and Flag-based actions so users can choose
their own digest interval. Enable it if you want that:

```bash
drush en message_digest_ui -y
```

## Next step

Message Digest ships with **daily** and **weekly** intervals ready to use.
Continue to [Configuration](../configuration/index.md) to review the intervals,
add your own, and route notifications through a digest notifier.
