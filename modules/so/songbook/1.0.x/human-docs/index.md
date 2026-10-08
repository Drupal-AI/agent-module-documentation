# Songbook — manual setup guide

**Songbook** (`songbook`) brings **ChordPro** support to Drupal, so you can
publish song lyrics with the chords positioned above the words. It integrates the
`intelektron/chordpro-php` library and provides a **text-format filter** that
parses ChordPro 6.x notation and renders it into formatted output — turning a
plain-text song into a properly laid-out chord sheet with just a few clicks. It is
aimed at songbook, worship and music sites.

The module can parse multiple chord notations (French names like *Do*, *Ré*,
*Mi*; German names like *H*, *Fis*; or custom ones), output in several formats
(HTML, JSON, or monospace), and read ChordPro metadata so you can record song
information and organise songs into sections. Developers can define custom
formatters and notations via an alter hook (see the module's `songbook.api.php`).

It depends only on core's **Filter** module. Because it is a text-format filter,
its effect is on how content is *rendered* — it plays no content or access-control
role. One thing to know up front: when you enable the ChordPro filter on a text
format, CKEditor is no longer used for fields on that format; the field appears as
a plain textarea in the edit form (which is what lets you type raw ChordPro).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer
   (which pulls in the ChordPro library) and enable it.

## How to use it

Songbook has no settings page of its own. To start using it, go to
**Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`) and either create a new text format or edit an
existing one, then enable the **"Parse as a ChordPro song with chords"** filter.
Any field using that text format will then render ChordPro input as a chord sheet.
The supported ChordPro syntax is documented in the `chordpro-php` library's
README.
