# Media: Keepeek DAM — manual setup guide

**Media: Keepeek DAM** (`media_keepeekdam`) connects Drupal's Media ecosystem to
the **Keepeek** Digital Asset Management platform. With it, editors can browse and
use Keepeek‑managed assets — images, responsive images, and videos — from within
the Media Library, while Keepeek handles the underlying storage and delivery of
those assets.

Keepeek is a widely used DAM (particularly in France) for capturing and governing
an organization's marketing and communication assets. This module is aimed at
Keepeek customers who deliver their digital experiences through Drupal and want
their editors to pull approved assets straight from the DAM rather than
re‑uploading copies into Drupal.

Connecting to Keepeek requires **API credentials** issued by Keepeek. Because those
credentials are secrets, they should be stored securely in an environment variable
(never committed to the repository) and referenced through Drupal — see
[Configuration](configuration/index.md) for the recommended approach.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside its core dependencies.
2. [Configuration](configuration/index.md) — obtain and securely store your Keepeek
   API credentials, and connect the module to your DAM.

## How to use it

Once the module is connected to your Keepeek account (see Configuration), editors
work with Keepeek assets through the familiar **Media Library** — selecting DAM
assets into media fields just as they would with locally uploaded media. Keepeek
remains the system of record for the assets themselves.
