# Configuration

Bunny (RabbitMQ Integration) is configured in your site's `settings.php` /
`settings.local.php`, not through an admin form. This keeps the connection
credentials in PHP settings — outside the database and, by convention, outside the
webroot and version control.

## 1. Make sure the AMQP library is present

The module needs `php-amqplib/php-amqplib` (`^3.1`) — installed automatically when
you require the module (see [Installation](../installation/index.md)). The `pcntl`
PHP extension is recommended so consumers can honor timeouts.

## 2. Add RabbitMQ credentials

In `settings.php` (or better, `settings.local.php`), define the connection:

```php
$settings['rabbitmq_credentials']['default'] = [
  'host' => 'localhost',
  'port' => 5672,
  'vhost' => '/',
  'username' => 'guest',
  'password' => 'guest',
];
```

### TLS

For an encrypted connection, add an `ssl` array with your certificate paths and
turn on peer verification:

```php
$settings['rabbitmq_credentials']['default']['ssl'] = [
  'cafile' => '/path/outside/webroot/ca.pem',
  'local_cert' => '/path/outside/webroot/client.pem',
  'local_pk' => '/path/outside/webroot/client.key',
  'verify_peer' => true,
  'verify_peer_name' => true,
];
```

Store the certificate files **outside the webroot**. Keeping `verify_peer` /
`verify_peer_name` on is what makes the TLS connection trustworthy.

You can also tune connection behavior with options such as `connection_timeout`
and `read_write_timeout`.

## 3. Route queues to RabbitMQ

Tell Drupal which queues should use RabbitMQ by pointing them at the
`queue.rabbitmq.default` service:

- **All queues (default):**
  `$settings['queue_default'] = 'queue.rabbitmq.default';`
- **A specific named queue:**
  `$settings['queue_service_<queue_name>'] = 'queue.rabbitmq.default';`
- **A reliable queue:**
  `$settings['queue_reliable_service_<queue_name>'] = 'queue.rabbitmq.default';`

If you want to override queue/exchange defaults, provide a
`config/install/rabbitmq.config.yml` in a small custom module.

## 4. Check the connection

Visit **Reports → Status report → RabbitMQ**
(`/admin/reports/status/rabbitmq`, requires *Administer site configuration*) to
confirm the connection is healthy.

## 5. Run the workers

Messages are consumed by workers, not by web requests. Run the consumers via the
module's Drush commands (or via cron). The module registers no anonymous or
mutating HTTP endpoints — all processing happens through Drush/cron.

## Security notes

- Credentials live only in PHP settings — never in the database or an admin UI.
  Keep `settings.php` / `settings.local.php` out of public version control.
- Enable `verify_peer` (and `verify_peer_name`) whenever you use TLS.
- The only route the module adds — the status page — is gated by *Administer site
  configuration*.
