<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LightGallery Formatter — agent index

A **media field formatter that displays media in a lightGallery lightbox** — images, remote video
(YouTube/Vimeo), and standard PDF Documents, rendered by a bundled React build (lightGallery 2.9.0 +
React 18.2.0, no external library install) with a static fallback for SEO / no-JS. Behaviour is driven by
reusable `lightgallery_profile` config entities at `/admin/config/media/lightgallery`, each toggling 11
feature plugins. Depends on core `media` and `media_library`. Provides one permission
(`administer lightgallery_formatter`) and config schema. Version **1.1.0**. Core `^10.3 || ^11 || ^12`.

Media/content-display — rendered media follows core media/file access (referenced media and the
PDF-thumbnail media are access-checked; captions and PDF filenames are escaped); no access role beyond the
admin permission that gates the profile UI.

## Solution docs

- `agent/configuration/profiles-and-formatter.md` — set up profiles, apply the formatter to a media field,
  tune the feature plugins, and configure thumbnails / PDF support.
