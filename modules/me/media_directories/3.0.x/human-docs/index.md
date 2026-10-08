# Media Directories — manual setup guide

**Media Directories** (`media_directories`) gives your Drupal Media library a **folder
structure**, backed by a taxonomy vocabulary. Every term in that vocabulary is a directory,
term nesting becomes folder nesting, and a *Directory* field on each media item records
where it lives. Instead of one long flat list of images, documents and videos, editors get
an organised, nested library they can browse — a big help once you have more than a handful
of assets.

The base module is intentionally small: it adds the *Directory* field to media, registers
a Views filter and a contextual filter so you can build directory-aware listings, and adds
an exposed *Directory* filter to core's Media Library and the admin media overview. Which
vocabulary acts as "the folders" is a single choice on its settings form — and that form
can even create a fresh vocabulary for you in one step. A *Show all files in Root
directory* option decides whether the Root folder shows only unfiled media (the default) or
everything.

Everything *visual* — the drag-and-drop browser, the CKEditor integrations, AI-generated
alt text and inline image resizing — lives in a set of optional **submodules** you enable
as needed (see the installation guide). The base module depends on core's **Media**,
**Media Library**, **Taxonomy** and **Views**, and needs Drupal `^10.2 || ^11 || ^12`. It
has no permission of its own; its settings form uses core's *Administer site configuration*.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable it,
   and choose which optional submodules you need.
2. [Configuration](configuration/index.md) — pick (or create) the folder vocabulary and
   set the Root behaviour.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → Media → Media directories**
(`/admin/config/media/media_directories`). The directory-aware media browser that the
`media_directories_browser` submodule adds lives at
`/admin/content/media-browser`.
