# Headless CMS — manual setup guide

**Headless CMS** (`headless_cms`) adds the conveniences you tend to miss when you
run Drupal as a decoupled (headless) backend for an external front end. Rather
than being one monolithic feature, it's a small collection of independent
submodules, each solving a common gap in a decoupled architecture, so you enable
only the pieces you need:

- **Preview** — lets content editors preview unpublished content and revisions in
  an external front-end application, so the usual "preview before publish"
  workflow still works when the rendered site lives outside Drupal.
- **Notify** — sends events (entity create/update/delete, cache rebuilds, and so
  on) out to front-end applications through pluggable transports. Webhook and
  NATS transports ship built in, so your front end can react — for example
  rebuild or revalidate — when content changes.

It is built on and deeply integrates with the
[Consumers](https://www.drupal.org/project/consumers) module, which means much of
its behaviour can be configured **per consumer** — different front-end
applications registered against your Drupal site can be treated differently.

Because a headless backend exposes content to API clients, treat the surrounding
setup — which consumers exist, CORS, and authentication — with care. See
[Configuration](configuration/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside the Consumers module, then turn on the submodules you
   need.
2. [Configuration](configuration/index.md) — the `administer headless_cms
   settings` permission, per-consumer configuration, and the security points to
   get right.

## Where it lives in the admin menu

Administration of Headless CMS is gated by the **`administer headless_cms
settings`** permission. Its features are configured per consumer via the
Consumers module, so much of the setup happens where your consumers are managed.
See [Configuration](configuration/index.md).
