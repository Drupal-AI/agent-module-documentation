# Brid.TV — manual setup guide

**Brid.TV** (`bridtv`) connects your Drupal site to the [Brid.TV](https://www.brid.tv/)
video platform. It adds Brid.TV as a media source so that videos hosted on Brid.TV
can be added, managed, and embedded through Drupal's normal core Media system —
the same way you would handle a local video file or a YouTube URL — rather than
pasting embed code by hand.

Once enabled, editors work with Brid.TV videos as ordinary media entities: they
live in the media library, can be referenced from media fields, and are displayed
using Drupal's media display settings. The player and video assets themselves are
loaded from Brid.TV's servers (a third‑party embed), and the module talks to the
Brid.TV service to handle the video data.

Because it connects to the Brid.TV service, you will need Brid.TV account details
(such as a player or partner identifier and any API credentials). Treat those
credentials as secrets — see [Installation](installation/index.md) for the
recommended way to store them in an environment variable rather than in committed
configuration.

This guide is written for a **human** setting the module up through the admin UI
and their site's configuration. If you want terse, token‑cheap references for an
AI coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, installing with Composer,
   enabling the module, and where to keep your Brid.TV credentials.

## Where it lives in the admin menu

Brid.TV does not add a top‑level admin section of its own. It plugs into core
**Media**: after enabling it you work with Brid.TV videos under **Content →
Media** (`/admin/content/media`) and when configuring media types under
**Structure → Media types** (`/admin/structure/media`). The module also defines
its own permissions, which you grant under **People → Permissions**
(`/admin/people/permissions`).

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Store your Brid.TV credentials in an environment variable so they are never
   committed to the repository.
3. Add Brid.TV videos as media entities and reference them from your content, then
   embed or display them using Drupal's normal media display settings. The player
   loads from Brid.TV.
