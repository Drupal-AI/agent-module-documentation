# Installation

## Requirements

- **Drupal 10.2, 11 or 12** (`core_version_requirement: ^10.2 || ^11`).
- The [Message](https://www.drupal.org/project/message) module (`message`).
- The [Message Notify](https://www.drupal.org/project/message_notify) module
  (`message_notify`).
- The [Pusher API](https://www.drupal.org/project/pusher_api) module (`pusher_api`) —
  which must be configured via `$settings['pusher_api']` in `settings.php`.
- **Recommended:** [Pusher User](https://www.drupal.org/project/pusher_user) to
  auto-subscribe logged-in users to their `private-user.{uid}` channel on the web.
- A **Pusher.com app**, or a self-hosted Pusher-protocol server such as
  [Soketi](https://soketi.app/) or pws.

This is an alpha release and is not covered by Drupal's security advisory policy, so
review it before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/message_pusher -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Message, Message
Notify and Pusher API and update shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/message_pusher -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en message_pusher -y
```

Enable `pusher_user` too if you want the automatic web subscription:

```bash
drush en pusher_user -y
```

## Verify it worked

Message Pusher registers a Message Notify notifier with the id `pusher`. After
enabling, it is available for sending; the delivery itself only works once you have
configured Pusher API credentials — continue to
[Configuration](../configuration/index.md). The bundled `README.md` includes test
instructions for confirming a message reaches a subscribed client.
