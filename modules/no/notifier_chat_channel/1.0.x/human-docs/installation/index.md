# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Notifier** module (`notifier`) — this is a required dependency, and it in
  turn requires PHP 8.3.
- For each chat service you target, the matching **Symfony Chatter transport**
  must be available (Composer pulls these in as you require them).

## Install with Composer

From the project root:

```bash
composer require drupal/notifier_chat_channel -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and will bring in Notifier if it is not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/notifier_chat_channel -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en notifier_chat_channel -y
```

Enabling this module enables Notifier as well if it is not already on.

## Verify it worked

Configure a chat transport (see [Configuration](../configuration/index.md)) for a
service you can watch — Slack, Discord, and Mercure are the tested options — and
send a test notification from code. If the message appears in the target chat
channel, the setup is working. If not, re‑check the transport DSN and that
outbound requests to the service are allowed from your environment.
