# Custom Purge — manual setup guide

**Custom Purge** (`custom_purge`) is a small, focused tool for **clearing caches
on demand** — both Drupal's own page cache and external caches or CDNs. It gives
you a form to purge specific URLs from your configured caching instances, plus
Drush commands to enqueue a full purge of everything. Its defining idea is a
**queue-based** approach: large "purge everything" operations are processed
gradually through Drupal's queue (paced by cron) rather than all at once, and each
caching target can carry its own delay before the complete purge actually runs.

It ships with a small plugin system and three built-in cache plugins out of the
box: Drupal's **internal page cache**, **Varnish**, and **Cloudflare**. If you
need a target it doesn't cover, you can add your own plugin. This is deliberately
a lean alternative to the full **Purge** module — if you need broad third-party
provider support and deep extensibility, that larger module is the better fit.

One thing to know up front: Custom Purge **does not ship a settings form** for its
main configuration. You set it up by editing its configuration YAML
(`custom_purge.settings.yml`) directly and importing it with `drush config:import`.
It does provide a **purge URLs form** in the admin UI for day-to-day URL purges,
and it defines its own permissions. It depends on Drupal core's **Page Cache**
module and needs a working cron (or a scheduled `drush queue:run`) to process the
queues.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — how to define your caching instances
   in YAML, run the purge form, and process the queues.

## Where it lives in the admin menu

Custom Purge provides a **purge URLs form** in the admin UI (guarded by its own
permission) for purging specific URLs from your configured caches. Its underlying
configuration, however, is managed as YAML config rather than a form — see
[Configuration](configuration/index.md) for the full picture.
