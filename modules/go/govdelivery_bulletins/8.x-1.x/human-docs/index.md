# GovDelivery Bulletins — manual setup guide

**GovDelivery Bulletins** (`govdelivery_bulletins`) lets a Drupal site create and
send **bulletins** — the email and SMS notifications that government
organisations send to their subscriber lists — through GovDelivery's (Granicus')
Communications Cloud *Bulletins* API. It provides a **service** for adding a
bulletin to a queue and a **queue** that is processed and delivered to
GovDelivery. It is deliberately more focused than the broader
[GovDelivery Integration](https://www.drupal.org/project/govdelivery) module.

An important thing to understand up front: this module does **not** create
bulletins on its own. It gives developers a clean service to call from custom
code — for example from a `hook_entity_insert()`, an event subscriber, or an
update hook — when your site decides a bulletin should go out. The service builds
the message (subject, body, SMS body, categories, topics, tracking flags) and
puts it on the queue; the queue then talks to the GovDelivery API. An external
trigger endpoint is also available for kicking off sends.

Because sends reach **real subscribers**, this module has genuine operational
weight. Two things deserve care. First, it authenticates to the GovDelivery API
with credentials that must be treated as **secrets** — kept out of exported
configuration and provided through your environment. Second, the ability to
trigger or queue bulletins must be limited to trusted users, because an accidental
send can go to a large audience. The module provides its own permissions for this,
and ships with its "send" switches turned **off** by default so you can set up and
test safely before anything is actually delivered.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — connect to the GovDelivery API,
   store credentials securely, and control when bulletins are actually sent.

## Where it lives in the admin menu

The admin settings form is the route
`govdelivery_bulletins.govdelivery_bulletins_admin_form`. It holds the GovDelivery
connection details and the "Basic operations" switches that decide whether
bulletins are queued and whether the queue is processed. See
[Configuration](configuration/index.md).

## How developers use it

To queue a bulletin from custom code, call the
`govdelivery_bulletins.add_bulletin_to_queue` service and chain the setters for
the message, then `addToQueueAndReset()`:

```php
\Drupal::service('govdelivery_bulletins.add_bulletin_to_queue')
  ->setQueueUid('some-unique-string') // Optional, but required if deduping.
  ->setFlag('dedupe', TRUE)           // Optional.
  ->setSubject('Some text for the email subject.')
  ->setBody('Some body text for the message.')
  ->setSMSBody('Some SMS text.')      // Optional.
  ->addCategory('emergency')          // Optional.
  ->addTopic('ABC-123')               // Optional.
  ->addToQueueAndReset();
```

To send a test to specific addresses without touching a subscriber list, set the
`test` flag and add explicit recipients:

```php
\Drupal::service('govdelivery_bulletins.add_bulletin_to_queue')
  ->setFlag('test', TRUE)
  ->addEmailAddress('test.recipient@example.org')
  ->addToQueueAndReset();
```
