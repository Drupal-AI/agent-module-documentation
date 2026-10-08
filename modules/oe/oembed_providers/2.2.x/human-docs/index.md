# oEmbed Providers — manual setup guide

**oEmbed Providers** (`oembed_providers`) extends Drupal core's Media system so you
can embed video and other content from providers core doesn't ship. Out of the
box, core Media fetches its oEmbed provider list from `oembed.com` and limits its
built-in "Remote video" source to YouTube and Vimeo. This module lets you **add
your own custom providers** and **group providers into "buckets"** that become
brand-new media sources.

A **custom provider** records a provider's name, URL, and one or more endpoints
(the URL patterns it handles and the formats it returns), and gets merged into the
list core Media uses. A **bucket** is a named set of allowed providers that is
exposed as its own `oembed:{bucket}` media source — so you can, for example,
create a "Remote image" source, or restrict a particular media type to just one
trusted provider. You can also turn off external fetching entirely and run purely
on your locally defined providers, which is handy for air-gapped or tightly
curated sites.

Everything is managed from an admin area under **Configuration → Media**, and all
of it — providers, buckets, and settings — is stored as configuration, so it
deploys between environments like any other config. A single permission gates all
of the module's administration. There's an important security caveat the UI itself
surfaces: disabling or removing a provider does **not** by itself stop Media from
rendering that provider's content while it's still in the repository, so treat
provider curation as a security decision.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including the
ProviderRepository decorator and the alter hook — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form, adding custom
   providers, and creating provider buckets.

## Where it lives in the admin menu

All of the module's screens live under **Configuration → Media → oEmbed
Providers** (`/admin/config/media/oembed-providers`):

- **Settings** — the main form (`/admin/config/media/oembed-providers`).
- **Custom providers** — `/admin/config/media/oembed-providers/custom-providers`.
- **Provider buckets** — `/admin/config/media/oembed-providers/buckets`.

Everything is gated by the *Administer oembed providers* permission.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Add a **custom provider** for the service you want to embed, giving it a name,
   URL, and at least one endpoint.
3. Optionally create a **bucket** grouping the providers you want, which becomes a
   new media source you can assign to a media type.
4. Adjust the **settings** if you need to disable external fetching or point Media
   at a different providers list.

See [Configuration](configuration/index.md) for the field-by-field walkthrough.
