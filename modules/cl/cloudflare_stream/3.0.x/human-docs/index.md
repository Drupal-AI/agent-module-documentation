# Cloudflare Stream — manual setup guide

**Cloudflare Stream** (`cloudflare_stream`) connects Drupal to Cloudflare's video
platform. When an editor uploads a video into a Cloudflare Stream field, the file
is pushed to your Cloudflare account (using a resumable TUS upload, so large files
survive interruptions) and played back through Cloudflare's own embed player. All
the heavy lifting — transcoding, storage, and adaptive/responsive delivery — happens
on Cloudflare's network instead of your server.

The module gives you a `Cloudflare Video` field type, a matching upload widget, and
video and thumbnail formatters, plus a `cloudflare_stream` **Media source** so you
can build a Media type backed by Cloudflare videos. Behind the scenes a
`cfstream://` stream wrapper and a small API service talk to Cloudflare's REST API
to upload, fetch details, and delete videos. It depends on core's **Media** module.

Unlike a simple formatter module, Cloudflare Stream does **not** work on enable
alone: you must first enter your Cloudflare credentials (an API token, your account
ID, and your customer subdomain) on its settings form, then add a Cloudflare Video
field or Media type where you want videos. The settings form verifies your token
against Cloudflare before it will save, so bad credentials are caught immediately.

The module ships one submodule, **Cloudflare Stream - Sync**
(`cloudflare_stream_sync`), which imports videos that already exist in your
Cloudflare account back into Drupal as Media items (and adds a Drush command for
scheduled imports). Enable it only if you need that direction of sync.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and (optionally) the Sync submodule.
2. [Configuration](configuration/index.md) — enter your Cloudflare credentials, set
   permissions, and add a Cloudflare Video field or Media type.

## Where it lives in the admin menu

The credentials/settings form is at **Configuration → Media → Cloudflare Stream →
Settings** (`/admin/config/media/cloudflare-stream/settings`). You add fields and
formatters through the usual **Manage fields / Manage display** screens on your
content types, and Media types under **Structure → Media types**.

## How to use it

At a glance: enter credentials on the settings form, add a **Cloudflare Video**
field (or a Media type using the Cloudflare Stream source), and let editors upload
through the field widget. Playback uses Cloudflare's player at
`https://<your-subdomain>.cloudflarestream.com/<video-id>/watch`. The full walkthrough
is in [Configuration](configuration/index.md).
