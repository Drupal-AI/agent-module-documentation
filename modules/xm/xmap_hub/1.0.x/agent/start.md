<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# XMAP Hub for LGD (xmap_hub) — agent index

**A block that embeds an XMAP 'find my nearest' / open-data hub, styled via query params, for LocalGov Drupal.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10
- **Package:** Custom

**Surface:** no routes/permissions/services. Block plugin `XmapHub` builds `<xmap_url>?<styling params>` (colors, font, width — each `urlencode`d) and renders via the `xmap_hub_content` Twig template. Default URL `https://demo.hub.xmap.cloud/`; XMAP account required. References `Drupal\ukscplugin\Helper` (external helper) in imports.

**Security:** block placement/config is admin-controlled (Block layout permissions); output is an editor-supplied embed URL with URL-encoded styling params. No anonymous or mutating server endpoints.
