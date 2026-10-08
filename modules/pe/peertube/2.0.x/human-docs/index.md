# Peertube — manual setup guide

**Peertube** (`peertube`) lets your editors add **PeerTube videos** to content as
Drupal **Remote Video** media, the same way they would add a YouTube or Vimeo
video. PeerTube is the federated, open‑source video platform, and it already
supports oEmbed — the protocol Drupal core uses for remote videos — so in principle
Drupal supports PeerTube natively.

There is one catch this module exists to solve. PeerTube is a *decentralised*
network: videos live on many different instances, each with its own domain name.
Drupal core, for security, only accepts remote videos from a fixed list of approved
provider domains. This module lets you register the PeerTube instances you want to
use as approved oEmbed providers, so their videos can be embedded through the media
system.

Setup is a short sequence: add your instance domains on the module's settings page,
allow the PeerTube provider in the **oEmbed Providers** module, and allow it on your
**Remote Video** media type. After that, editors paste a PeerTube URL just like any
other remote video. As with any remote/oEmbed media, the video is fetched from the
source PeerTube instance at display time, so its content and availability depend on
that instance being up.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module
   and the oEmbed Providers dependency.
2. [Configuration](configuration/index.md) — add your PeerTube instance domains and
   wire up the oEmbed provider and Remote Video media type.

## Where it lives in the admin menu

- Add your PeerTube instance domains: **Configuration → Media → PeerTube**
  (`/admin/config/media/peertube`, route `peertube.settings`).
- Allow the provider: **Configuration → Media → oEmbed Providers → Custom
  providers** (`/admin/config/media/oembed-providers/custom-providers`).
- Allow it on the media type: **Structure → Media types → Remote video → Manage**
  (`/admin/structure/media/manage/remote_video`).

See [Configuration](configuration/index.md) for the full walkthrough.
