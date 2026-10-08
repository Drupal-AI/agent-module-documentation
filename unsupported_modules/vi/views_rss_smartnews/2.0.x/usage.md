<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Extends the Views RSS module with the extra feed elements required by SmartNews' SmartFormat specification, so a Views RSS display can produce a SmartNews-compliant news feed.

---
SmartNews ingests publisher content through a specialised RSS feed with its own namespace and fields (analytics, advertising, thumbnails, full-text content, etc.). This module plugs into Views RSS as an extension, registering those SmartNews-specific channel and item elements via hooks so they become selectable in a Views RSS feed display; it does not itself expose a UI, routes, permissions or services — configuration happens entirely in the Views RSS settings of your feed view. Once the elements are mapped, the resulting feed can be checked with SmartNews' own validator.

There is no security surface of its own: the module is a small `.module` file of element definitions layered on top of `views_rss`, with no HTTP endpoints, no outbound calls and no stored secrets. Setup is: install Views RSS 2.x, enable this module, then add and map the SmartNews elements in your RSS view.
---
- Output a SmartNews-compliant RSS feed from a view.
- Register SmartNews SmartFormat feed elements in Views RSS.
- Map SmartNews channel-level metadata in a feed view.
- Map SmartNews item-level fields (thumbnails, content, etc.).
- Syndicate news content to the SmartNews service.
- Validate the feed with SmartNews' validator.
- Add the SmartNews namespace to an existing RSS view.
- Extend an existing Views RSS feed with SmartNews support.
- Publish full-text article content in the feed.
- Provide SmartNews-required advertising/analytics elements.
- Reuse a normal Views RSS display as a SmartNews feed source.
- Keep SmartNews feed config alongside other RSS feeds.
- Expose article thumbnails to SmartNews' SmartFormat.
- Provide the SmartNews RSS namespace declaration.
- Map SmartNews advertising slots in the feed.
- Add SmartNews analytics elements to feed items.
- Feed a SmartNews channel from an existing content view.
- Maintain SmartNews feeds without custom feed code.
