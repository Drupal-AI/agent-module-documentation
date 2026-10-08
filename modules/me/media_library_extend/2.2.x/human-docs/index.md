# Media Library Extend — manual setup guide

**Media Library Extend** (`media_library_extend`) lets you add extra source tabs — the module
calls them **panes** — to Drupal core's Media Library, so editors can pull media from services
other than local upload. Out of the box the Media Library offers upload and, with core, an
oEmbed video tab; this module makes it possible to add tabs for stock-photo services, a DAM, a
third-party media provider, or any API you can talk to, and have a selected remote asset
downloaded into a real Drupal media entity automatically.

It is primarily a **developer / site-builder framework**. It defines a `MediaLibrarySource`
plugin type (the code that fetches and previews items from a source) and a `media_library_pane`
config entity (which binds one source plugin to one media type, with per-pane options). By
itself the module ships only two *example* image plugins — `lorem_picsum` and
`configurable_lorem_picsum`, which fetch placeholder images from picsum.photos — so on its own
it is mainly useful for prototyping and testing. Real value comes from a custom source plugin
you write, or from a contrib plugin such as Media Library Youtube.

The module depends on core's **Media Library** module and works on Drupal 10.1+ / 11. Enabling
it changes nothing visible until you create a pane: a pane only appears as a tab in the Media
Library when its media type is one the field being edited is allowed to use. It provides config
schema for panes but **no permissions of its own** — the pane admin screens are gated by core's
*Administer site configuration* — and no Drush commands.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent — the plugin interface, the base class helpers,
and the alter hook — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it alongside core
   Media Library.
2. [Configuration](configuration/index.md) — creating and managing panes, choosing a source
   plugin and media type, and the shipped example plugins.

## Where it lives in the admin menu

Panes are administered at **Configuration → Media → Media library → Panes**
(`/admin/config/media/media-library/pane`), gated by the *Administer site configuration*
permission. Configured panes then surface as extra tabs inside the Media Library dialog wherever
their media type is allowed for the field being edited.
