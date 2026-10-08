# Brightcove Video Connect — manual setup guide

**Brightcove** (`brightcove`) connects your Drupal site to the
[Brightcove](https://www.brightcove.com/) Video Cloud platform. It signs in to your
Brightcove account with OAuth credentials, mirrors your Brightcove videos,
playlists, players, custom fields, and text tracks (captions/subtitles) into local
Drupal entities, and can push brand‑new videos back up to Brightcove via Dynamic
Ingest. In short: your editors manage video from inside Drupal, and the two systems
stay in sync.

You start by registering one or more **API Clients** — each is a saved connection to
a Brightcove account, holding that account's ID and OAuth credentials. You can
register several, so one site can manage multiple Brightcove accounts. Once a client
is connected, Brightcove content syncs into Drupal through queues that run on cron,
on demand from a status page, or via the `drush brightcove:sync-all` command. Editors
can then embed a Brightcove player for a video, reference videos from nodes, tag
them, and list them with the bundled Views.

Syncing also works the other way. **Subscriptions** register a notification endpoint
with Brightcove so that when someone changes a video over in Brightcove, the change
flows back to your Drupal entities. And when an editor uploads a new video from
Drupal, an ingestion callback finalizes it once Brightcove finishes processing.

The module has a fair number of dependencies (it pulls in Inline Entity Form, Token,
Time Formatter, and several core modules) and ships three optional submodules:
**Brightcove Proxy** (route API traffic through an HTTP/SOCKS proxy), **Media
Brightcove** (a "Brightcove Video" media source for reusable media), and **Brightcove
Gallery** (experimental In‑Page Experience galleries).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   and choose submodules.
2. [Configuration](configuration/index.md) — register an API client, tune cron,
   set up subscriptions, grant permissions, and run the first sync.

## Where it lives in the admin menu

The main hub is **Configuration → Media → Brightcove Video Connect API Client
settings** (`/admin/config/media/brightcove_api_client`), where you register
accounts. Related pages include the cron settings
(`/admin/config/system/brightcove_cron`), subscriptions
(`/admin/config/system/brightcove_subscription`), and the sync status report at
**Reports → Brightcove** (`/admin/reports/brightcove`).

## How to use it

1. Enable the module and register an **API Client** with your Brightcove Account ID,
   Client ID, and secret.
2. Run a sync (cron, the status page, or `drush bcsa`) to pull your Brightcove
   library into Drupal.
3. Grant the relevant permissions so editors can add, edit, and view videos.
4. Embed or reference the synced videos in your content.

The full walkthrough is in [Configuration](configuration/index.md).
