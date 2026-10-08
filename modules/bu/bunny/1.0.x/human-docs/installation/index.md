# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A running **RabbitMQ** server to connect to.
- The **`php-amqplib/php-amqplib`** PHP library (`^3.1`) — the AMQP client the
  module uses.
- Recommended: the **`pcntl`** PHP extension, which enables consumer timeouts.

> **Note on the project name:** `drupal/bunny` is the RabbitMQ Integration project
> (it `replace`s `drupal/rabbitmq`). It is not related to Bunny CDN.

## Install with Composer

From the project root:

```bash
composer require drupal/bunny -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Requiring the module also brings in the
`php-amqplib/php-amqplib` library. (If you manage dependencies explicitly, ensure
`"php-amqplib/php-amqplib": "^3.1"` — and optionally `"ext-pcntl": "*"` — are in
your site's root `composer.json`.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/bunny -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bunny -y
```

Keep the module enabled whenever you are using RabbitMQ Integration.

## Next step

The connection is configured in `settings.php`, not the UI. Continue to
[Configuration](../configuration/index.md) to add your RabbitMQ credentials and
route queues to RabbitMQ.
