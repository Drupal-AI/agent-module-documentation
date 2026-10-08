# Bunny Optimizer — manual setup guide

**Bunny Optimizer** (`bunny_optimizer`) serves your Drupal images through
[Bunny.net](https://bunny.net/)'s **Bunny Optimizer** — its CDN image-optimization
service. Instead of Drupal processing and serving images locally, image requests
are optimized and delivered from Bunny's edge network, which can reduce image
weight and offload the work from your server.

It hooks into Drupal's image handling (it depends on core File and Image plus the
[File Metadata Manager](https://www.drupal.org/project/file_mdm) module) so that
images render through Bunny's optimizer. It is a performance / media / CDN feature
and has no access-control role of its own.

A couple of honest caveats worth knowing:

- **Images go to a third party.** Delivery depends on Bunny.net and its terms, and
  image requests travel to Bunny's edge.
- **A CDN adds no access control.** Images served through the CDN are exactly as
  public as their source — putting them behind Bunny doesn't make them private.
- **Treat your Bunny.net credentials as secrets** and use HTTPS. See
  [Configuration](configuration/index.md) for how to handle them.

It requires **PHP 7.4** and runs on Drupal 9.3+, 10, and 11.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it with its dependencies.
2. [Configuration](configuration/index.md) — point the module at your Bunny.net
   pull zone and handle credentials safely.

## Where it lives in the admin menu

Bunny Optimizer adds settings where you provide your Bunny.net details so images
can be routed through the Optimizer. See [Configuration](configuration/index.md)
for what you need to supply and how to keep the credentials out of committed
config.
