# Mautic API — manual setup guide

**Mautic API** (`mautic_api`) is the base integration that connects Drupal to one or
more **Mautic** instances. Mautic is an open‑source marketing‑automation platform,
and this module is the connectivity layer other Mautic modules build on: it
authenticates to Mautic's API and manages the connections and webhooks used to push
and pull data — contacts, events, segments — between Drupal and Mautic.

On its own it is an **API module** rather than a finished feature. It does not add
marketing behaviour to your site by itself; instead, other modules use it to provide
that. For example, *Commerce Mautic* uses Mautic API to create contacts and send
mails on order completion. If you're installing Mautic API, it's usually because
another module asked for it, or because you're writing custom code against Mautic.

Its notable strength is **multi‑instance** support: you can define several Mautic
connections and manage them independently, each with its own credentials and
webhooks. Because those credentials grant access to your marketing platform, store
them securely (backed by an environment variable rather than plain config) and
restrict the administration permissions the module provides.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its `rest` dependency.
2. [Configuration](configuration/index.md) — add Mautic connections and webhooks,
   store credentials securely, and restrict the admin permissions.

## Where it lives in the admin menu

Mautic API manages **connections** and **webhooks** through its own administrative
UI, gated by the permissions `administer mautic_api_connection` and
`administer mautic_api_webhook`. It depends on core's **REST** module and supports
Drupal 10 and 11.
