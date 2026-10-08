# Lightning Media — manual setup guide

**Lightning Media** (`lightning_media`) is the media‑authoring layer from the
Lightning distribution. It sits on top of core's **Media** and **Media Library**
and makes creating media feel much slicker: editors get a **live preview** of a
source as they fill in the form (paste a YouTube URL or a tweet and see it render),
"type or drop anything and Drupal works out the media type" **input matching**, a
per‑item **"Show in media library"** switch, a couple of extra view modes, and — via
optional submodules — eight ready‑made media types (audio, document, image,
Instagram, slideshow, tweet, video and more).

The base module itself owns no media types; it improves the plumbing. Its central
idea is *input matching*: given a file, a URL or an embed code, it can work out which
media type should handle it, turn that input into a media entity, and validate the
file against the matching type's own rules. It swaps in an improved media form that
shows the live source preview and can optionally expose the media revision UI. It
also gives every media type a `field_media_in_library` checkbox so editors can hide
working files from the library, and it integrates with Entity Browser, Inline Entity
Form and Entity Embed when those are present.

The eight component **submodules** are where the actual media types live — each one
adds a single media type (and pulls in whatever library it needs). You enable only
the ones you want. A single settings form at *Configuration → Media → Lightning
Media* controls the two global toggles.

This guide is written for a **human** installing and configuring the module through
the admin UI. If you want the terse, token‑cheap reference for an AI coding agent —
the `MediaHelper` service, the `InputMatchInterface`, the shipped config and the
plugins it implements — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base
   module, and pick the component submodules you need.
2. [Configuration](configuration/index.md) — the two settings on the *Lightning
   Media* form, the per‑item "Show in media library" switch, and the image‑widget
   options.

## Where it lives in the admin menu

The module's settings form is at **Configuration → Media → Lightning Media**
(`/admin/config/system/lightning/media`). Your media types, view modes and
displays are managed in the normal core places under *Structure → Media types* and
*Structure → Display modes*.

## How to use it

1. **Enable the base module** plus the component submodules for the media types you
   want (see [Installation](installation/index.md)).
2. **Create or use media** in the normal way (*Content → Media → Add media*, or the
   media library inside a rich‑text field). You'll notice the live source preview
   and the automatic type detection as you work.
3. **Tune the two global toggles** on the *Lightning Media* settings form if you
   want the media revision UI, or want editors to be able to choose an embed
   display (see [Configuration](configuration/index.md)).
4. **Hide working files** from the library per item with the *Show in media library*
   checkbox that appears on every media form.
