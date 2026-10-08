# Linkit Media Library — manual setup guide

**Linkit Media Library** (`linkit_media_library`) adds a **Media Library** button inside
CKEditor 5's Link dialog, so editors can link selected text to a media item — typically a
document such as a PDF — picked from the media library, instead of pasting a file URL. It is
the natural way to build "download the brochure" links: the editor highlights some words,
opens the link dialog, browses the media library, and picks the file.

Because the link stores the media item's UUID rather than a raw path, the link keeps working
even if the underlying file is later replaced or renamed — Linkit's URL converter resolves
the real address at render time. Links open in a new tab automatically. The module is a thin
bridge between three existing systems — **Linkit 7**, core's **Media Library**, and
**CKEditor 5** — and it has **no settings page or configuration of its own**. Setup is done
entirely through your Linkit profile and text format: the profile needs a media matcher (the
module adds one to the *default* profile on install), and the format needs Linkit's filter
and CKEditor extension turned on.

It requires Drupal core `^10.3 || ^11`, the **Linkit** module (`^7`) and core's **Media
Library** module, and it defines no permissions or Drush commands.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.
2. [Configuration](configuration/index.md) — enable media linking on a text format via its
   Linkit profile.

## Where it lives in the admin menu

The module has no page of its own. You configure it across two core screens: **Linkit
profiles** at **Configuration → Content authoring → Linkit profiles**
(`/admin/config/content/linkit`) and **Text formats and editors** at
**Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`).
