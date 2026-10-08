# Media Orange Logic — manual setup guide

**Media Orange Logic** (`media_orange_logic`) connects an **Orange Logic (Cortex)
digital asset management (DAM) system** to Drupal's media layer. Editors can
search the DAM from inside Drupal — through an entity browser widget or, partially,
the Media Library — and reference its assets (images, audio, video) as Drupal media
without leaving the content form.

Under the hood it provides an entity‑browser widget, a media source, an "Orange
Logic" field type that stores the full asset payload, and audio/video field
formatters, all wired together so DAM assets flow into your content editing. It
authenticates to the DAM with credentials you configure, obtains and caches an API
token, and issues advanced searches (by keyword, artist, media type, system
identifier, and more). Two optional submodules extend it: **Media Orange Logic
Samples** ships example media types and an entity browser to get you started, and
**Orange Logic Media Library** adds a Media Library source (currently image media
only).

You need an Orange Logic DAM to use this module, and the module is explicitly
described by its maintainers as **under active development** — review it against
your needs before relying on it. Two things to weigh up front:

- **Egress and credentials.** The module makes server‑side calls out to your DAM's
  API using stored credentials. Store secrets securely (see
  [Configuration](configuration/index.md)) and make sure your environment allows
  outbound HTTPS to the DAM.
- **A broadly‑gated AJAX endpoint.** The admin credential form is properly
  permission‑gated, but the entity‑browser AJAX route
  (`/media-orange-logic/eb/ajax/selected-assets`) is gated only by the "access
  content" permission — effectively anonymous on many sites — and proxies
  caller‑supplied asset IDs into a DAM search using the site's stored token,
  returning rendered thumbnails and metadata. That means low‑privilege users could
  enumerate or retrieve DAM asset data with your site's credentials. Review this
  against your DAM's access model before exposing the site publicly.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (note the extra
   dependency and patches), enable it, and pick submodules.
2. [Configuration](configuration/index.md) — enter and securely store your DAM API
   and token endpoints and credentials.

## Where it lives in the admin menu

Its credential/settings form sits at **Configuration → Media → Media Orange
Logic** (`/admin/config/media/media-orange-logic`), and requires the **Administer
Orange Logic** permission (plus access to administration pages).
