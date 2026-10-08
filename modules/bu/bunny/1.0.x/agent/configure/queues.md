<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring RabbitMQ-backed queues

> Note: `drupal/bunny` is the RabbitMQ Integration project (it `replace`s `drupal/rabbitmq`) — not Bunny CDN.

## 1. Dependency
Add to the site root `composer.json` (not core's): `"php-amqplib/php-amqplib": "^3.1"` and, recommended, `"ext-pcntl": "*"`, then `composer update`.

## 2. Credentials (settings.php / settings.local.php)
```php
$settings['rabbitmq_credentials']['default'] = [
  'host' => 'localhost', 'port' => 5672, 'vhost' => '/',
  'username' => 'guest', 'password' => 'guest',
];
```
For TLS add an `ssl` array with `cafile`, `local_cert`, `local_pk`, and `verify_peer => true`, `verify_peer_name => true` (store certs outside the webroot).

## 3. Route queues to RabbitMQ
- Default: `$settings['queue_default'] = 'queue.rabbitmq.default';`
- Named: `$settings['queue_service_<queue_name>'] = 'queue.rabbitmq.default';`
- Reliable: `$settings['queue_reliable_service_<queue_name>'] = 'queue.rabbitmq.default';`

## 4. Operate
- Health: `/admin/reports/status/rabbitmq` (`administer site configuration`).
- Consumers run via the module's Drush commands / cron.
- Override queue/exchange defaults in a custom module's `config/install/rabbitmq.config.yml`.

## Security
Credentials never touch the database or a web UI; they stay in PHP settings. Enable `verify_peer` for TLS connections.
