# DROWL Media — manual setup guide

**DROWL Media** (`drowl_media`) gives a Drupal site a sensible **media setup out
of the box**. It ships DROWL's default Media entity configuration and a set of
enhancements — ready‑made media types and field configuration, plus nicer styling
for the Media Library and for media‑item previews (for example in entity
reference fields). Rather than building media types from scratch, you enable this
module and start with a practical, opinionated baseline.

It depends only on core **Media**. Two optional submodules extend it:
**DROWL Media Types** (`drowl_media_types`) adds the ready‑made media types, and
**DROWL Media Video** (`drowl_media_video`) adds video handling. Enable whichever
you need. The module configures media types and handling only — media access still
follows core's media and file access, and it adds no access control of its own.

Two practical notes from the project page. The style enhancements assume you are
using the **Gin** or **Claro** admin theme (Gin is preferred; the Claro styles are
not actively maintained). And the **4.x** line uses Drupal core's standard media
field names and Bootstrap‑based templates — it is a deliberate break from the
older Foundation‑based 3.x, with no automatic upgrade path, so upgrading an
existing 3.x site needs care. This module is a building block for the rest of the
DROWL feature set, notably
[DROWL Header Slides](../../drowl_header_slides/4.1.x/human-docs/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and pick the submodules you need.

There is **no configuration page** for this module — it installs default media
configuration you then manage through Drupal's normal media administration.

## Where it lives in the admin menu

DROWL Media adds no settings page of its own. After enabling it, the media types
and fields it provides are managed the usual way at **Structure → Media types**
(`/admin/structure/media`), and its styling improvements appear automatically in
the **Media Library** and in media reference field previews (with Gin or Claro).
