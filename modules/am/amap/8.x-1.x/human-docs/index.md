# aMap — manual setup guide

**aMap** (`amap`) adds an interactive map to your site as a **block**. Instead of
embedding a map into one specific page, you place aMap's block into a region and
it displays a map of your content's locations. The map is loaded via AJAX, so it
is fetched after the page rather than being baked into the initial HTML.

It is a display-only feature: it takes location data associated with your nodes
and shows it on a map that visitors can interact with. It has no content model or
access-control role of its own — it simply renders a map wherever you place the
block. Because it is a block, you can use Drupal's normal block visibility
settings to decide which pages it appears on.

aMap builds on core **Node** and **Block**, so it fits into the site-building
tools you already use. Enable it, place the block, and the map appears.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

After enabling the module, go to **Structure → Block layout**
(`/admin/structure/block`), click **Place block** in the region where you want
the map to appear, and add the aMap map block. Use the block's visibility
conditions if you only want the map on certain pages. The map loads via AJAX and
shows the location data from your content.
