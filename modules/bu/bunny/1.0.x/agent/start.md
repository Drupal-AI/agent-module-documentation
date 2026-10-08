<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bunny (RabbitMQ Integration) (bunny) — agent index
**Forward namespace for RabbitMQ Integration — backs Drupal Queue API with a RabbitMQ/AMQP server. NOT Bunny CDN.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10 || ^11
- **Composer:** `drupal/bunny` `replace`s `drupal/rabbitmq`; requires `php-amqplib/php-amqplib:^3.1`
- **Queue services:** `queue.rabbitmq.default` (default / reliable / per-queue via `$settings`)
- **Credentials:** `$settings['rabbitmq_credentials']` in settings.php (host/port/vhost/user/pass/ssl)
- **Route:** `rabbitmq.properties` → `/admin/reports/status/rabbitmq` (`_permission: administer site configuration`)
- **Security:** Credentials in PHP settings (outside DB/webroot). Status route admin-gated. SSL example uses `verify_peer`/`verify_peer_name` with certs. No anonymous/mutating HTTP endpoints.

See [configure/queues.md](configure/queues.md)