# oEmbed Providers — manual setup guide

**oEmbed Providers** (`oembed_providers`) extends Drupal core's built-in oEmbed
support so site builders can manage which remote-media providers are available and
add ones core doesn't know about. Core Media can embed remote video from a fixed
list of providers fetched from `oembed.com`; this module lets you add your own
custom providers through the admin UI, group providers into "buckets" that become
new media sources, globally enable or disable providers, change (or switch off)
the provider-list URL, and more.

You'd reach for it when you want to embed media from a provider that isn't in
core's default list, when you want a media type restricted to only certain
providers (via a bucket), or when your site should rely solely on your own custom
providers and never call out to `oembed.com`.

Two things are worth knowing before you start. First, this module **replaces core
Media's provider repository service** with an extended version, so it is
**incompatible with other modules that also modify that same service**. Second,
core Media does not let you change the media source of an existing media type — so
plan your buckets before you create media types around them. The module depends on
core's **Media** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — global settings, adding custom
   providers, and creating provider buckets.

## Where it lives in the admin menu

Everything lives under **Configuration → Media → oEmbed Providers**
(`/admin/config/media/oembed-providers`):

- the **global settings** form (route `oembed_providers.settings`),
- **Custom providers** (`/custom-providers`) — add and manage your own providers,
- **Buckets** (`/buckets`) — group providers into media sources.

All of it is gated by the **Administer oEmbed providers** permission.
