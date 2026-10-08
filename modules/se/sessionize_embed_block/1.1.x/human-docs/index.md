# Sessionize Embed Block — manual setup guide

**Sessionize Embed Block** (`sessionize_embed_block`) provides a configurable Drupal
block that embeds a [Sessionize](https://sessionize.com) widget — the sessions,
schedule and speakers for an event. Sessionize is a cloud-based event-planning
platform that conference organizers use to manage their call for papers, speakers
and agenda; this module lets you surface that agenda on your Drupal site. It was
originally built for DrupalCampNYC but is useful for any Drupal event site.

You configure a site-wide default Sessionize embed ID and pick one of six embed
styles (four supported styles and two "retired" ones), then place the block into any
region of your theme through Drupal's normal Block Layout. The block renders the
Sessionize widget in place.

One thing worth knowing before you use it: the block loads a **third-party embed
script from Sessionize**, so the agenda content and its assets come from Sessionize's
servers — you're trusting that provider, though the content is public event data. The
module has no access-control role of its own beyond a permission, and needs no other
modules. Supports Drupal 9.3, 10 and 11 (and can still be installed on Drupal 8 to
ease an upgrade path). Note that this project is not covered by Drupal's security
advisory policy.

This guide is written for a **human** setting the module up through the admin UI. If
you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set your Sessionize embed ID and style,
   then place the block.

## Where it lives in the admin menu

The settings form sits at **Configuration → Web services → Sessionize Embed Block**
(`/admin/config/services/sessionize_embed_block`). The block itself is added through
**Structure → Block Layout** (`/admin/structure/block`), where you place it into any
region of your theme.
