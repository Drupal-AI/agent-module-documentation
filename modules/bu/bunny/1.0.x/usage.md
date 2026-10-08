<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bunny is the forward-looking project namespace for the RabbitMQ Integration for Drupal; it lets Drupal's Queue API be backed by a RabbitMQ (AMQP) server instead of the database.
---
Despite the name, this module is *not* Bunny CDN — its `composer.json` `replace`s `drupal/rabbitmq` and it ships the RabbitMQ Integration submodule (`rabbitmq`). The integration registers queue services (e.g. `queue.rabbitmq.default`) so any Drupal queue — the default queue, the reliable queue, or a named queue — can be routed to RabbitMQ via `$settings`. Connection credentials (host, port, vhost, username, password, and optional SSL certs) are supplied in `settings.php`/`settings.local.php` under `$settings['rabbitmq_credentials']`, not in the database or a UI. A status report page (`/admin/reports/status/rabbitmq`) shows connection health.

Operationally it depends on a running RabbitMQ server and the `php-amqplib/php-amqplib` library (`^3.1`), with `ext-pcntl` recommended for consumer timeouts. Security posture is sound for its type: credentials live in PHP settings (kept out of the webroot and version control by convention), the status route is gated by `administer site configuration`, and the README's SSL example enables `verify_peer`/`verify_peer_name` with CA and client certs. There are no anonymous or mutating HTTP endpoints; message consumption runs via Drush/cron workers.
---
- Install `php-amqplib/php-amqplib` (`^3.1`) via the site's root composer.json.
- Keep the Bunny module enabled when using RabbitMQ Integration.
- Add `$settings['rabbitmq_credentials']['default']` in settings.local.php.
- Set RabbitMQ as the default queue with `$settings['queue_default'] = 'queue.rabbitmq.default'`.
- Route a specific queue with `$settings['queue_service_<name>']`.
- Route a reliable queue with `$settings['queue_reliable_service_<name>']`.
- Offload cron/background jobs to RabbitMQ.
- Configure TLS with `ssl` certs and `verify_peer` in credentials.
- Tune `connection_timeout` / `read_write_timeout` options.
- Check connection health at `/admin/reports/status/rabbitmq`.
- Run consumers via the module's Drush commands.
- Override queue/exchange defaults via `config/install/rabbitmq.config.yml`.
- Install `ext-pcntl` for consumer timeout support.
- Scale message processing independently of the database.
- Use the rabbitmq_example submodule as a reference implementation.