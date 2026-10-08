<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Sticky Social Bar shows a sticky bar of social-share links, rendered as a block and configured from an admin settings page.
---
The module provides a settings form at `/admin/config/media/sticky-social-bar` (permission `administer site configuration`) where you enable/disable individual share channels and options, and a block that renders the sticky bar (with supporting CSS/JS libraries and a Twig template). It can build share links for the current page as well as for arbitrary URLs, and integrates with `token` and the `field` module for value replacement. A helper include (`sticky_social_bar.inc`) assembles the markup.

Setup: enable the module, visit the settings page, turn on the social networks you want, and place/enable the "Sticky Social Bar" block in a region (typically the footer). It targets legacy through current Drupal (8–11). This is primarily a presentational/front-end feature; the admin form is permission-gated and there are no public mutating endpoints.
---
- Display a sticky social-share bar on the page.
- Show share buttons pinned to the footer/bottom.
- Enable or disable individual social networks.
- Configure the bar at `/admin/config/media/sticky-social-bar`.
- Place the sticky social bar as a block in a region.
- Share the current page URL to social platforms.
- Share an arbitrary/other site URL.
- Use tokens to build share URLs and text.
- Style the bar via the module's CSS library.
- Override the bar markup through its Twig template.
- Add share links for taxonomy or content-type pages.
- Restrict the admin form to trusted roles.
- Provide quick sharing to Facebook/X/LinkedIn/etc.
- Keep sharing controls visible while users scroll.
- Toggle only the channels relevant to your audience.
- Integrate share links into a marketing page.
- Reuse the block across multiple content types.
- Customise which pages show the bar via block visibility.
- Localize share labels through the theme.
- Support older Drupal 8/9 sites as well as 10/11.
