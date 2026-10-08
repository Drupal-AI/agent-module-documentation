# Configuration

Configuring Purge means **assembling a pipeline**: something to feed the queue, a
queue to hold invalidations, something to drain it, and a purger to actually flush
your external cache. Purge core has no configuration page of its own — you do all
of this either through the **Purge UI** submodule dashboard or with the `p:*` Drush
commands. Under the hood the enabled plugins are stored in the `purge.plugins`
configuration object.

## Open the Purge dashboard

1. Enable the **Purge UI** submodule if you haven't already
   (`drush en purge_ui -y`).
2. Log in as a user with the **Administer site configuration** permission (an
   administrator by default — Purge defines no permission of its own; its UI uses
   that core permission).
3. Go to **Configuration → Development → Performance → Purge**
   (`/admin/config/development/performance/purge`).

The dashboard shows each part of the pipeline with links to add, configure, order,
or remove plugins, and a diagnostics panel that flags anything misconfigured.

## The four pieces you configure

- **Queuers** — what *feeds* the queue. Almost always the **Core tags queuer**
  (`purge_queuer_coretags`), which automatically queues every cache tag Drupal
  invalidates. Enable its submodule and add it here.
- **Queue** — where invalidations wait. Exactly **one** queue plugin is active; the
  default `database` queue is the right choice for most sites.
- **Processors** — what *drains* the queue and pushes invalidations to the purgers.
  Add the **Cron processor** for background processing, and/or the **Late runtime
  processor** for lower-latency clearing at the end of each request. You can run
  both.
- **Purgers** — the plugins that talk to your external cache (Varnish, a CDN, etc.).
  These come from a separate proxy/CDN module, not from Purge. You can enable more
  than one, and **their order matters** — arrange them on the dashboard. Without at
  least one purger, nothing is actually flushed.

## Capacity and diagnostics

- **Capacity tracker** — Purge automatically rate-limits how many invalidations are
  processed per request, based on cost and limits declared by your purgers. This
  protects your origin from being overwhelmed; you generally don't set a number by
  hand, but it's why very large queues drain gradually.
- **Diagnostic checks** — shown on the Purge dashboard and on the site **Status
  report**. They catch problems such as "no purger installed" or "capacity too low"
  and can block processing until resolved. Check them from the CLI with
  `drush p:diagnostics`.

## Driving and testing from Drush

The `purge_drush` submodule adds `p:*` commands that mirror the UI and are handy for
testing and automation, for example:

- `drush p:diagnostics` — review the current pipeline health.
- `drush p:queue-work` — drain (process) the queue now.
- `drush p:invalidate` — trigger a specific invalidation (by tag, path, URL, etc.).

## Save and confirm

After adding your queuer, queue, processors, and a purger, re-check the diagnostics
panel (or `drush p:diagnostics`) — it should report a healthy pipeline with no
blocking issues. Then edit a piece of content and confirm the corresponding entry
is cleared from your external cache.
