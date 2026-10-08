<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Autogenerate site icon formatter (autogeneration_site_icon_formatter) — agent index
**A `social_media_link` field formatter for Link fields that fetches and caches each URL's favicon.**

- **Version:** 1.0.x (dev-1.0.x checkout; no packaged release)
- **Core:** ^8.8.0 || ^9 || ^10 || ^11
- **Depends on:** field
- **Formatter:** `social_media_link` (`AutoGenerationSocialMediaLinkFormatter`) for `link` field types; settings `social_media_link` (display mode) and `social_media_size`.
- **Theme:** `social_media_link_formatter` (`templates/social-media-link-formatter.html.twig`).
- **Cache dir:** `public://social-media-icons/`.

**Security:** No routes, permissions or forms. At render time it makes a server-side outbound HTTP request per link host (host derived from the editor-controlled field value, appended as a path to a hardcoded third-party favicon service) and writes files to the public filesystem. Responses are constrained by a content-type allow-list and a 1 MB size cap. See [configure/formatter.md](configure/formatter.md).
