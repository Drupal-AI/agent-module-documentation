# Content Sync (content-sync.io) — manual setup guide

**Content Sync** (`cms_content_sync`) syndicates content between multiple Drupal
sites. It lets you push and pull entities — nodes, media, taxonomy terms, menu
links, paragraphs, files and more — from one site to others, so you can run
editorial workflows like drafting on a central "staging" site and publishing out
to live sites, distributing a shared media library to affiliate sites, or keeping
a fleet of brand micro-sites in sync with a headquarters source of truth.

The syndication itself is coordinated by an external **"Sync Core" backend**
hosted by content-sync.io. Your Drupal sites register with that backend and then
exchange content through it. Because of this, the module needs a
content-sync.io / Sync Core account to do anything — nothing syncs without a
backend to talk to.

You describe what to sync with two configuration entities:

- **Pools** — a shared channel that participating sites connect to, identified by
  the Sync Core backend URL. A site can join several pools to take part in
  independent syndication channels.
- **Flows** — what *this* site pushes or pulls: which entity types and bundles,
  in which direction, and to or from which pools.

Under the hood, each entity is serialized by pluggable **entity handlers** and
**field handlers** so that references, files, translations, paragraphs and layout
data travel correctly between sites. Syncing can happen automatically on save,
manually from dashboards embedded from the backend, or in bulk from the command
line. Sync credentials are encrypted at rest using bundled encryption modules and
a key entity.

The project ships eight optional submodules adding things like Views integration,
a health dashboard, Simple Sitemap and DraggableViews support, an Acquia Content
Hub migration path, developer tooling, and support for private/local environments
the backend cannot reach directly.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the suite with Composer,
   enable it, and pick the submodules you need.
2. [Configuration](configuration/index.md) — registering the site with the
   backend, creating Pools and Flows, the encryption key, and the permissions.

## Where it lives in the admin menu

The admin area is at **Configuration → Web services → Content Sync**
(`/admin/config/services/cms_content_sync`), gated by the **Administer cms content
sync** permission. Many of the screens there are embedded from the content-sync.io
backend. There are also Drush commands for registration, bulk push/pull and
configuration export.

## How to use it

At a high level: sign up for a content-sync.io backend, install and enable the
module, register your site with the backend, create a Pool for the shared channel
and a Flow describing what this site should push or pull, then let content
syndicate automatically or trigger it manually. See
[Configuration](configuration/index.md) for the steps and the important note about
replacing the encryption key placeholder.
