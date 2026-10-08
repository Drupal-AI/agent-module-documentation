# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A running **external Notification Server** instance (or a compatible API) —
  this is what actually brokers the HTTP/WebSocket traffic. The module is only
  the Drupal‑side client.
- **Redis**, which the notification server uses for its data storage.

There are no additional Composer library or PHP version constraints declared by
the module itself.

## Install with Composer

From the project root:

```bash
composer require drupal/notification_server -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/notification_server -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Stand up the companion server

The module needs the external notification server to talk to. If you develop
with **DDEV**, the maintainer provides an add‑on that sets this up for you:

```bash
ddev add-on get d34dman/ddev-notification-server
ddev restart
```

Outside DDEV you will need to run the notification server (and its Redis
dependency) yourself, using the project's own deployment instructions, and point
Drupal at it.

## Enable the module

```bash
drush en notification_server -y
```

## Verify it worked

The module ships no user‑facing screen, so the practical test is to publish a
message from code and confirm a connected client receives it:

```php
\Drupal::service('notification_server.client')
  ->publishNotification('test_channel', 'It works!');
```

If the companion server is running and reachable, a client subscribed to
`test_channel` should receive the message in real time. If nothing arrives,
check that the notification server (and Redis) are up and that Drupal's
connection details point at the right host.
