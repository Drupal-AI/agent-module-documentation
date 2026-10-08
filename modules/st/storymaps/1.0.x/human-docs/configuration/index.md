# Configuration

ArcGIS StoryMaps has two steps: fill in the settings page so the module knows which
StoryMap to show, then place the block where you want it to appear.

## Open the settings page

1. Log in as a site administrator.
2. Go to **Configuration → Web services → ArcGIS StoryMaps**, or navigate directly
   to `/admin/config/services/arcgis-storymaps`.

## Settings

- **Story ID** — the identifier of the published ArcGIS StoryMap you want to embed.
  This is what the module uses to build the embed script. Copy it from the StoryMap
  in ArcGIS.
- **Root node selector** — the selector for the element the StoryMaps embed should
  attach to (its root node) when it renders on the page.

Save the settings once both values are set.

## Place the block

The module provides a **custom block** that outputs the ArcGIS StoryMaps embed
using the values you saved. Make it appear on your site in either of these ways:

- **Block layout** — go to **Structure → Block layout** (`/admin/structure/block`),
  place the StoryMaps block in a region, and optionally set visibility so it only
  shows on the pages you want.
- **Referenced in content** — reference the block inside a content type, for
  example using the Block Field module, so editors can drop the StoryMap into
  individual pieces of content.

## A note on third-party content

The embed loads the StoryMap from Esri/ArcGIS at render time, so visitors' browsers
contact Esri's servers. Keep that in mind for privacy and cookie-consent purposes,
and be aware the module is not covered by Drupal's security advisory policy.
