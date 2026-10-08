<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sticky Social Bar (sticky_social_bar) — agent index
**Configurable sticky social-share bar rendered as a block.**

- **Version:** 8.x-1.x (8.x-1.1)
- **Core:** ^8 || ^9 || ^10 || ^11
- **Depends on:** field, token
- **Configure:** `/admin/config/media/sticky-social-bar` (`administer site configuration`)
- **Permission:** `administer sticky_social_bar`
- **Block:** "Sticky Social Bar" (place in a region, e.g. footer); assets in `css/`, `js/`, template in `templates/`; markup helper `sticky_social_bar.inc`.

**Security:** admin settings route is permission-gated; the feature is presentational (share links) with no anonymous or mutating endpoints. Note: the shipped `links.task.yml` contains placeholder "Foo/Bar" local tasks.
