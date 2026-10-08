# Bunny (RabbitMQ Integration) — manual setup guide

**Bunny** (`bunny`) is the forward-looking project namespace for **RabbitMQ
Integration** for Drupal. Despite the name, this is **not Bunny CDN** — its
`composer.json` `replace`s `drupal/rabbitmq`, and it ships the RabbitMQ
Integration submodule (`rabbitmq`). What it does is let Drupal's Queue API be
backed by a **RabbitMQ (AMQP) server** instead of the database.

In practice, that means the background work Drupal queues up — cron jobs, the
default queue, reliable queues, or any named queue — can be routed to RabbitMQ so
that message processing scales independently of your database. The module
registers queue services (such as `queue.rabbitmq.default`) that you point your
queues at.

Connection details — host, port, virtual host, username, password, and optional
TLS certificates — are supplied in your site's `settings.php` /
`settings.local.php`, **not** through the database or an admin form. A status
report page shows whether the RabbitMQ connection is healthy. Messages are
consumed by workers you run via Drush or cron; the module exposes no anonymous or
mutating HTTP endpoints.

It depends on a running RabbitMQ server and the `php-amqplib/php-amqplib` PHP
library (`^3.1`), with the `pcntl` PHP extension recommended for consumer
timeouts. It runs on Drupal 9, 10, and 11.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the required
   AMQP library with Composer, and enable it.
2. [Configuration](configuration/index.md) — add RabbitMQ credentials in
   `settings.php` and route your queues to RabbitMQ.

## Where it lives in the admin menu

There is no configuration form — connection settings live in `settings.php`. The
one admin page it adds is a **status/health page** at **Reports → Status report →
RabbitMQ** (`/admin/reports/status/rabbitmq`), gated by the *Administer site
configuration* permission, where you can check that the connection is working.
