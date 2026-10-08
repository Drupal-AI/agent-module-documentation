# Configuration

Symfony Mailer Queue is configured entirely through Symfony Mailer's own **policy**
system — there is no separate settings page. You decide which mail gets queued by
adding the **Queue sending** email adjuster to a mailer policy, and you tune the
retry behaviour on that same adjuster.

## Attach the Queue sending adjuster to a policy

1. Go to **Configuration → System → Mailer** (`/admin/config/system/mailer`).
2. Add or edit the mailer policy whose mail you want to queue. You can queue a
   broad policy (all mail) or a narrow one (say, just user-registration mail),
   leaving every other policy to send inline as before.
3. Add the **Queue sending** email adjuster to that policy and configure its
   settings (below).

## The queue settings

- **Queue Behavior** — what happens to an item when a send fails. Choose from:
  - **Delayed requeue** *(default)* — the failed item becomes available again only
    after the requeue delay (or once its lease expires). Drupal's database queue
    supports these delays; queue backends that do not fall back to a one-minute
    lease.
  - **Immediate requeue** — the failed item is available for reprocessing right
    away, and might even be retried within the same queue run.
  - **Suspend queue** — the failed item is requeued and the rest of the queue is
    held back until the next scheduled run, which is useful when the mail server
    is down and you would rather pause everything than keep hammering it.
- **Requeue delay** *(default 60 seconds)* — how long to wait before a failed item
  is retried, when using delayed requeue.
- **Maximum attempts** — a cap on how many times a message is retried, so a
  permanently broken address eventually stops being retried.
- **Email send wait time** — a wait applied when sending items, to pace delivery.

## Processing the queue on cron

Queued mail is only delivered when the `symfony_mailer_queue` queue is processed.
The queue worker is registered to run on cron, so if your site runs cron
regularly the mail will go out on its own. Because retries and delayed requeues
depend on frequent processing, it is recommended to schedule frequent cron runs —
the [Ultimate Cron](https://www.drupal.org/project/ultimate_cron) module is one
way to do that. There are two relevant jobs to be aware of:

- the module's **default cron handler**, which performs the garbage collection
  needed to release queue items back for processing; and
- the **queue** itself, which actually sends the emails and retries failures.

If you use delayed requeuing, that garbage collection must be configured so items
are released when their delay expires.

## A note on the deprecated module-level settings

Earlier versions had a module-level `symfony_mailer_queue.settings` object holding
`maximum_attempts`, `requeue_delay` and `send_wait_time`. That object is
**deprecated for removal** — its schema is retained only to support migration.
Configure these values on the per-policy **Queue sending** adjuster instead. When
you uninstall the module it cleans up after itself, removing both the old settings
and the Queue sending adjuster from every mailer policy.
