# Configuration

Configuring Mail Entity Queue is a two-part job: you create and tune **queues** in
the admin UI, and then your code adds **items** to those queues. This page covers
the admin side.

## Create a queue

1. Log in as an administrator and go to **Configuration → System → Mail entity
   queues** (`/admin/config/system/mail-entity-queue`).
2. Add a new queue. Give it a **label** and a **machine name** — you'll use that
   machine name later when your code loads the queue to add items.

Each queue can be throttled with a few limits:

- **Number of items per cron run** — how many messages this queue may send each
  time cron runs. Keep this modest if your mail provider enforces rate limits.
- **Delay between items** — how long to wait between sending one item and the
  next, to spread the load out rather than sending in a tight burst.
- A per-item **number of attempts** limit is planned but may not yet be
  implemented in this release.

You can also choose which **processor** the queue uses. The bundled default
processor sends items through Drupal core's email system; if another module
provides an alternative processor, it becomes selectable here.

## Add items to the queue (in code)

There is **no UI for composing or adding messages** — items are added
programmatically. Load the queue by its machine name and call `addItem()`, passing
the recipient and a parameters array with the subject, body, and headers. For
example:

```php
$queue = \Drupal::entityTypeManager()
  ->getStorage('mail_entity_queue')
  ->load('my_queue');

$to = 'recipient@example.com';
$params = [
  'subject' => 'My awesome email',
  'body' => ['Body of the email'],
  'headers' => [
    'From' => 'info@example.com',
    'Sender' => 'info@example.com',
  ],
];

$queue->addItem($to, $params);
```

Only trusted code paths should enqueue mail — treat this like any other bulk
sending capability and keep the content and recipients trusted.

## Manage queued items

Once items exist, manage them at **Structure → Mail queue items**
(`/admin/structure/mail-entity-queue`). From there you can **view, edit, delete,
or process** each item individually — handy for inspecting a stuck message or
forcing one through outside the normal cron cycle.

## Make sure cron runs

Queued items are sent when **cron** runs and the queue's processor picks them up,
honouring the per-run count and delay you set. Make sure your site has a reliable
cron schedule; for finer control over when and how the queue drains, a tool like
Ultimate Cron is a good companion.

## Permissions

The module provides its own permissions for administering queues and items. Grant
them only to trusted operators at **People → Permissions**
(`/admin/people/permissions`) — a bulk email system in the wrong hands is a spam
risk.
