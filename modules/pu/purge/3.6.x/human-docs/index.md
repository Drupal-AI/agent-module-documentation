# Purge — manual setup guide

**Purge** (`purge`) is a generic, pluggable framework for invalidating **external**
caches — reverse proxies and CDNs such as Varnish, Fastly, or CloudFront — when
your Drupal content changes. When you edit or delete content, Drupal knows exactly
which cache tags are affected; Purge's job is to reliably carry that knowledge out
to the edge cache so it flushes precisely the right entries, rather than blunt-force
clearing everything.

It's important to understand what Purge *is not*: it ships **no** integration with
any specific cache on its own. It is the coordination layer. **Queuers** capture
Drupal's cache-tag invalidations and add them to a **queue**; **processors** later
drain that queue and hand each invalidation to the configured **purgers** — and the
purgers are the plugins that actually talk to Varnish or your CDN. Those purgers
come from a separate module for your particular proxy or CDN, which you install
alongside Purge. A **capacity tracker** rate-limits the work so your origin is never
overwhelmed, and **diagnostic checks** warn you on the status report when something
is misconfigured (for example, no purger installed).

Because of that design, Purge does **not** do anything useful the moment you enable
it — you need to enable the pieces of the pipeline (a queuer, a processor, and a
purger from a proxy/CDN module) and configure them. Everything is plugin-based:
Purge defines seven plugin types (purger, processor, queuer, queue, invalidation,
diagnostic check, tags header), stores the enabled plugins in `purge.plugins`
config, and provides a full set of `p:*` Drush commands. Purge itself declares no
hard module dependencies.

Several optional submodules provide the common pipeline pieces and the admin UI —
see the table in [Installation](installation/index.md#submodules--the-pipeline-pieces).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install Purge with Composer, enable it,
   and pick the submodules (and a purger module) you need.
2. [Configuration](configuration/index.md) — assembling the pipeline: queuer,
   queue, processors, and purger, plus capacity and diagnostics.

## Where it lives in the admin menu

Purge core has no configuration page of its own. Configuration is done through the
optional **Purge UI** submodule, which adds a dashboard at **Configuration →
Development → Performance → Purge**
(`/admin/config/development/performance/purge`), or entirely from the command line
with the `drush p:*` commands. See [Configuration](configuration/index.md).
