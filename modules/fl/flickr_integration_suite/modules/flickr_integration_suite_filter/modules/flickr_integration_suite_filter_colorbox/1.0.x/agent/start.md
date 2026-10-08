<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Flickr Filter Colorbox (flickr_integration_suite_filter_colorbox) — agent index

Nested submodule of **flickr_integration_suite_filter**. Opens filter-embedded Flickr images in a
**Colorbox** lightbox. Version **1.0.6**. Core `^10.3 || ^11`.
Depends on `colorbox` and `flickr_integration_suite_filter`.

Only meaningful with the filter — there is nothing to lightbox otherwise.

**Two notes:** Colorbox is a **jQuery** library, so this puts jQuery on any article containing a
Flickr embed (relevant on a site that has otherwise moved off it); and a lightbox is a keyboard
and screen-reader surface — verify focus enters on open, returns on close, and Escape works. A
lightbox that traps focus is worse than a link.