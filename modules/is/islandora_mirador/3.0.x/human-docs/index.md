# Islandora Mirador — manual setup guide

**Islandora Mirador** (`islandora_mirador`) embeds the
[Mirador](https://projectmirador.org) IIIF image and document viewer into an
[Islandora](https://www.islandora.ca) digital-repository site. It renders a IIIF
Presentation manifest for a repository item, giving you deep-zoom viewing of
archival scans (TIFF/JP2), multi-page book/paged-content viewers, image tools like
brightness and contrast, and — for OCR'd material — selectable, screen-reader
accessible text overlays. You can drop the viewer onto a page as a **block** or as a
**field formatter** for image/file fields.

The manifest that Mirador displays is addressed by a **token pattern** (default
`[node:url:unaliased:absolute]/manifest`), which Islandora's `islandora_iiif` REST
view normally serves per node. A single admin settings form controls everything
else: where the Mirador JavaScript library comes from (a remote CDN build or a
self-hosted local copy), which Mirador plugins are enabled, the viewer theme
(light/dark/system plus primary/secondary palette colors), interface-language
support, and the manifest URL pattern.

Islandora Mirador also defines a small plugin type (`IslandoraMiradorPlugin`) whose
implementations inject options into Mirador's per-window configuration — two ship
in-box, **Mirador Image Tools** and **Text Overlay** (hOCR text selection and
accessibility). An important thing to understand: the enabled-plugins checkboxes
only *toggle configuration flags*; the actual plugin code must already be compiled
into the Mirador build you are serving. By default that build loads from a jsDelivr
CDN, or you can compile and self-host your own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside its Islandora dependencies.
2. [Configuration](configuration/index.md) — the settings form field by field:
   library source, plugins, theme/palette, language, and the manifest URL pattern.

## Where it lives in the admin menu

The settings form is at **Configuration → Media → Mirador**
(`/admin/config/media/mirador`), gated by core's **Administer site configuration**
permission (the module adds no permission of its own). The viewer itself is placed
either as the **Mirador** block through **Block layout** (or via Islandora
Contexts), or as the **Mirador** field formatter on an image/file field's *Manage
display*. See [Configuration](configuration/index.md).
