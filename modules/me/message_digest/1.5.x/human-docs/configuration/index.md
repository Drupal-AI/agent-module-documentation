# Configuration

Message Digest has two parts to set up: the **digest intervals** (managed in the
admin UI) and the step where your notifications are actually sent through a
**digest notifier** (done in code or by another module such as Message
Subscribe).

## Manage digest intervals

Digest intervals are configuration entities. Manage them at **Configuration →
Message → Message digest** (`/admin/config/message/message-digest`), which
requires the **Administer message digest** permission. Two intervals ship ready
to use:

- **Daily** — an interval of `1 day`.
- **Weekly** — an interval of `1 week`.

Each interval has these fields:

- **Label** — the human-readable name, also used as the notifier's title.
- **Machine id** — becomes part of the notifier id (for example the `daily`
  interval produces the notifier `message_digest:daily`).
- **Description** — shown in frequency option lists (for example in the Message
  Digest UI submodule).
- **Interval** — a `strtotime()`-compatible string such as `1 day`, `1 week`, or
  `3 days`. This is what the module uses to work out when each user's next digest
  is due.

Use *Add*, *Edit*, and *Delete* on this page to manage the list.

### Adding a custom interval

Add a new interval from the admin form, or from the command line — for example a
three-day digest:

```bash
ddev drush php:eval '
\Drupal::entityTypeManager()->getStorage("message_digest_interval")->create([
  "id" => "threeday",
  "label" => "Every 3 days",
  "description" => "Sends messages in 3 day intervals.",
  "interval" => "3 days",
])->save();'
ddev drush cr
```

Clear the cache after saving so the module picks up the new interval. It then
becomes usable as the notifier `message_digest:threeday`.

## Route notifications through a digest notifier

Defining an interval on its own does nothing until your notifications are sent
using its notifier. Wherever a message would normally be sent with an immediate
notifier, send it with the digest notifier id instead:

```php
\Drupal::service('message_notify.sender')->send($message, [], 'message_digest:daily');
```

When a message is sent this way, Message Digest records it in the
`message_digest` table rather than emailing it immediately. On the next cron run,
users whose interval has elapsed have their pending messages grouped, rendered,
and sent as a single digest email.

> **Cron is required.** Digests are assembled and delivered on cron using a
> queue, so make sure cron runs on a regular schedule. The bookkeeping (which
> rows are pending, when each user was last sent to) is cleaned up automatically
> when the referenced message or user is deleted.

## For developers — altering digests

Two alter hooks let other modules customise how a digest is built, both fired
while a user's digest is being assembled:

- **`hook_message_digest_aggregate_alter()`** — regroup or reorder the messages,
  or switch from per-entity grouping to a single global digest.
- **`hook_message_digest_view_mode_alter()`** — change the message view modes
  used to render the digest, or set `deliver` to `FALSE` to stop a digest from
  sending (for example, to skip blocked users).

See the sibling [`agent/`](../../agent/hooks/hooks.md) docs for the exact
signatures and examples.
