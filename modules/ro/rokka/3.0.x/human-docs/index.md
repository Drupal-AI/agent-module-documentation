# Rokka — manual setup guide

**Rokka** (`rokka`) integrates the [Rokka.io](https://rokka.io) image processing
service and CDN with Drupal's file system. Once configured, it transparently
replaces local image storage and image-style handling: instead of saving uploads
to your server and generating derivatives locally, images are stored in and served
from Rokka, and every resize, crop, and optimization is produced by Rokka's cloud
on demand.

The point of doing this is to offload image storage, processing, and delivery to a
fast global CDN — taking that load off your own server and speeding up how images
reach your visitors. All the standard Drupal image-style effects are supported,
plus some extra Rokka-only effects, and there is support for adaptive-rate HLS
video streaming. It has been used successfully alongside modules such as Focal
Point and core Media.

The module is actively maintained and works on Drupal 9, 10, and 11. It provides
its own permissions and a set of Drush commands — most usefully
`drush rokka:migrate-imagestyles`, which syncs your existing image styles to Rokka
"stacks" so current styles keep working after you switch over.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enter your Rokka credentials and
   sync your image styles.

## Where it lives in the admin menu

The Rokka settings form is provided by the `rokka.admin_settings` route — you will
find it under **Configuration** once the module is enabled. This is where you enter
your Rokka organization and API credentials before anything can be stored or served
through Rokka.

## A note on data flow

Images stored in Rokka are served from Rokka's CDN. That is exactly what you want
for public images, but it means you should think carefully before routing
**access-restricted** images through a public CDN — a CDN URL is reachable by
anyone who has it. The module uses TLS for its requests to Rokka. Treat your Rokka
API credentials as secrets; see [Configuration](configuration/index.md) for how to
store them safely.
