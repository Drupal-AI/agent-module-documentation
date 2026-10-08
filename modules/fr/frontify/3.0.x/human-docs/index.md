# Frontify Integration — manual setup guide

**Frontify Integration** (`frontify`) connects Drupal's media system to
[Frontify](https://www.drupal.org/project/frontify), a digital-asset-management
(DAM) and brand platform. Instead of uploading images locally, editors browse your
organisation's Frontify-hosted assets from inside Drupal and use them as Drupal
media — so Frontify stays the single source of brand-approved assets while your
content simply references them.

The heart of the integration is the **Frontify Finder**, a media browser that
wraps up client authentication and asset selection in a single flow. You can link
Frontify to specific image fields on your site, pick assets from the Finder in
those fields or in WYSIWYG editors, and search and filter the library out of the
box. The Finder is context-aware: it respects your Drupal field configuration for
things like allowed file types, minimum/maximum resolution, and required
selections. Frontify can coexist alongside your other file and image storage.

The module integrates with core **Media**, **Media Library**, and **Block
Content**, and it ships a `frontify_colorbox` submodule for lightbox display. It
governs how assets are sourced and displayed, not who can access your content.

Because the connection uses Frontify credentials/API access, store those as secrets
and scope them appropriately — see the configuration guide.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it and its media dependencies, and pick the Colorbox submodule if you want it.
2. [Configuration](configuration/index.md) — connect Drupal to your Frontify
   account and store the credentials safely.

## Where it lives in the admin menu

Once enabled, configure the Frontify connection at the module's settings page
(config route `frontify.admin_config_frontify`, under **Configuration → Media**).
You then use the Frontify Finder from your media fields and WYSIWYG editors when
adding content.
