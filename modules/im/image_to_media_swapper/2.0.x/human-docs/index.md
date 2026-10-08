# CKEditor file to media swapper — manual setup guide

**CKEditor file to media swapper** (`image_to_media_swapper`) converts
file‑based images and file links inside rich‑text content into reusable Drupal
**media entities**. Legacy content often points straight at raw files (an
`<img src>` or an `/sites/default/files/…` link) instead of using Drupal's
structured media system, which leaves you with duplicate files and unmanaged
assets. This module finds or creates a media entity for each such file and
rewrites the markup to a `<drupal-media>` embed — either interactively while
editing, or in bulk across existing content.

It works two ways. In **CKEditor 5**, it adds a **Convert to Media** toolbar
button: select an image (or a file link, with the Linkit module) and click to
convert it, confirming in a dialog. For content that already exists, a **batch
tool** scans chosen text fields and converts embedded images and file links
across many entities at once. To avoid clutter, it reuses an existing media
entity whenever one already points at the same file rather than creating
duplicates, and it tracks each conversion in a `media_swap_record` entity.

The module is security‑minded: its conversion API requires the *create media* and
*update media* permissions plus a per‑request check (CSRF token, same‑host
Origin/Referer, and a rate limit), and remote‑URL imports are hardened against
SSRF (private/internal IPs blocked, HTTPS enforceable, size/redirect/timeout
caps, dangerous extensions and MIME types rejected). The batch tool is gated
behind the restricted **access batch media swapper** permission.

> **This changes your content.** Converting rewrites the markup stored in your
> fields (images become `<drupal-media>`, file links become media references).
> **Take a database backup and run the batch tool on a copy first**, then spot‑
> check the results before running it on production content.

It requires **CKEditor 5**, **Media Library**, and **Serialization**, with
**Linkit** recommended for converting file links.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it and
   its dependencies.
2. [Configuration](configuration/index.md) — add the CKEditor button, allow
   `<drupal-media>` in your text format, and tune the security settings.

## Where it lives in the admin menu

- The **security settings** form is at **Configuration → Media → File to Media
  Swapper** (`/admin/config/media/file-to-media-swapper/settings`).
- The **batch conversion** tool is under **Content → Media** (batch file‑to‑media
  swapper), with a manual queue form alongside it.
- The **Convert to Media** button is added per text format at **Configuration →
  Content authoring → Text formats and editors**.

## How to use it

1. Enable the module and its dependencies (see [Installation](installation/index.md)).
2. Add the **Convert to Media** button to a CKEditor 5 text format and allow
   `<drupal-media>` in that format (see [Configuration](configuration/index.md)).
3. **Convert while editing:** in CKEditor, select an image (or a file link, with
   Linkit) and click **Convert to Media**, then confirm in the dialog. The image
   becomes a `<drupal-media>` embed; the file link becomes a media reference.
4. **Convert in bulk:** back up your database first, then open the batch swapper
   under **Content → Media**, pick the text fields to process, run it, and review
   the results.
