# Colorbox — manual setup guide

**Colorbox** (`colorbox`) is a *lightbox* for Drupal: instead of opening an image
on its own page, it displays the image in an overlay ("modal") that floats on top
of the current page, with the rest of the page dimmed behind it. Under the hood it
wires the light-weight jQuery Colorbox plugin into Drupal and exposes it as an
**image-field formatter** — so any image field can be set to open in the lightbox,
and a multi-value image field becomes a browsable gallery with Prev/Next
navigation. It depends only on core's **Image** module and runs on Drupal 10.2+
and 11.

This guide is written for a **human** clicking through the admin UI. It walks you,
step by step and with screenshots, from installing the module and its JavaScript
library to configuring the global lightbox style and switching an image field over
to the Colorbox display. If you are looking for terse, token-cheap references for
an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

![The Colorbox settings page under Configuration → Media](images/settings.png)

## Where it lives in the admin menu

The global settings sit under **Configuration → Media → Colorbox**
(`/admin/config/media/colorbox`). That single page controls the lightbox's visual
style and behaviour for the whole site.

The part that actually turns lightboxing *on* for a given field lives elsewhere: on
each entity's **Manage display** screen (for example **Structure → Content types →
*(your type)* → Manage display**), where you set an image field's format to
**Colorbox**.

## Contents

1. [Installation](installation/index.md) — install Colorbox with Composer, enable
   it, and add the required Colorbox JavaScript library.
2. [Configuration](configuration/index.md) — choose the lightbox style, tune the
   default or custom options, and switch an image field to the Colorbox formatter.
