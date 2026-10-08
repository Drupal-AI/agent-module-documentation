<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
XMAP Hub for LGD provides a configurable block that embeds an XMAP "find my nearest" and open-data hub, aimed at LocalGov Drupal council sites.

---

The block (`XmapHub`) builds a URL to a hosted XMAP hub (default `https://demo.hub.xmap.cloud/`) and renders it through the `xmap_hub_content` Twig template. Its block form lets an editor set the XMAP URL plus presentation options — Google font family, primary/secondary colours, quick-links background, heading and sub-heading colours, page background and max width — each of which is URL-encoded and appended as a query parameter (`primary_color`, `font_family`, `width`, etc.) so the embedded hub renders in the council's branding. An XMAP account is required for a real hub URL.

Setup: place the "XMAP Hub" block in a region, enter your XMAP hub URL and adjust the colour/font/width fields. The block validates that width is numeric and rejects the literal `empty` as a URL. It has no routes, permissions or server-side data handling; it only composes a query string and hands the URL to a template. Note it references a `Drupal\ukscplugin\Helper` class in its `use` statements, implying an environment where that helper package is present.

---
- Place the "XMAP Hub" block in a page region.
- Embed an XMAP "find my nearest" hub on a council site.
- Publish open-data content through the XMAP hub.
- Point the block at your own XMAP hub URL.
- Match the hub to site branding via primary/secondary colours.
- Set a Google font family for the embedded hub.
- Configure quick-links background and heading colours.
- Set the page background colour of the embed.
- Constrain the embed width in pixels.
- Provide residents a location-based information tool.
- Reuse the block across multiple landing pages.
- Theme the embed output via the `xmap_hub_content` template.
- Validate width is numeric before saving the block.
- Support LocalGov Drupal council deployments.
- Swap the demo hub URL for a production XMAP account URL.
- Adjust styling without touching CSS by using the block form.
