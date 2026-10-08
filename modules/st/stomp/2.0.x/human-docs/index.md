# STOMP — manual setup guide

**STOMP** (`stomp`) lets Drupal hand its queue work off to an external message
broker that speaks the STOMP protocol — such as ActiveMQ or RabbitMQ. STOMP stands
for Simple (or Streaming) Text Orientated Messaging Protocol. The module provides
an alternative **queue backend**: instead of Drupal storing queued jobs in its own
database, jobs are pushed to and pulled from the message broker, so background work
can be processed in a decoupled, scalable way outside the Drupal request cycle.

It is a developer/infrastructure integration. There is no content, no block, and no
click-through feature for end users — you point Drupal's queue system at a broker,
and queue items flow through STOMP. The module has been developed and tested mainly
against ActiveMQ, so if you run it against another STOMP server the maintainers
welcome feedback.

Setting it up has two sides: a running STOMP broker configured to accept STOMP
connections, and Drupal configured with the broker's connection details and
credentials. Those credentials are sensitive — store them via an environment
variable rather than committing them, and reference them from your settings rather
than hard-coding them. It requires PHP 8.1+ and the `stomp-php/stomp-php` PHP
library, and supports Drupal 9, 10, and 11.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead. For the full connection and queue
configuration, see the module's own `README.md`, which the maintainers keep as the
authoritative reference.

## Contents

1. [Installation](installation/index.md) — install the module and the STOMP PHP
   library with Composer, then enable it.

## How to use it

Once installed, you stand up a STOMP-capable broker (ActiveMQ's getting-started and
STOMP guides walk through this) and then configure Drupal to use STOMP as a queue
backend, supplying the broker host, port, and credentials. Drupal's queue API then
routes the queues you assign to it through the broker instead of the database. Keep
the broker credentials in an environment variable and reference them from
`settings.php` — never commit them. The module's `README.md` documents the exact
configuration keys.
