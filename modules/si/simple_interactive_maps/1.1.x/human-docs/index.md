# Simple Interactive Maps — manual setup guide

**Simple Interactive Maps** (`simple_interactive_maps`) lets you embed an SVG map
whose regions respond to interaction — hover, click, and link. It is the right tool
when a "map" is really a **diagram with named areas** rather than something that
needs latitude and longitude: electoral regions, a floor plan, a network schematic,
a country divided into sales territories. Pushing those through a coordinate‑based
mapping library is more work for a worse result; an SVG with identified paths is the
natural representation, and this module makes those paths interactive.

In practice you upload the SVG, associate its regions with content or links, and the
map becomes clickable. It ships with a **US map of the 50 states** (plus hotspots for
major territories) and US **state maps showing counties** derived from Census shape
files, and additional maps can be defined through a simple plugin structure, so any
custom map can be added. Region behaviour is customisable too, with three actions
included out of the box: a **Navigation** plugin that turns the map into a visual
navigation tool, a **Modal Content** plugin that pops up a dialog with content
related to the clicked region, and an **AJAX map loader** that lets one map load
another.

The module has no central settings form; it works through map entities you upload and
the display of your content, drawing on core **File** and **Filter** and the
**Field Group** module. Two considerations deserve real attention:

- **An SVG is an XML document** that can contain scripts and external references, so
  the upload path matters. Uploading maps is an administrator task, gated by the
  module's own **administer interactive_map** permission — keep it that way. If you
  delegate SVG uploads more widely, understand that an SVG upload is effectively an
  HTML upload, and make sure the content is sanitised.
- **An interactive map is only accessible if the interaction is.** Regions that
  respond to hover and click need keyboard equivalents and accessible names, and a
  map used for navigation needs a non‑map alternative — a plain list of the same
  links — for anyone who cannot use it. This is a content requirement rather than a
  module setting, and it is the part most often skipped.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, install
   its dependencies, and enable it.

## How to use it

After enabling the module (and with the *administer interactive_map* permission):

1. **Upload or choose a map.** Use one of the bundled maps (US states, US counties)
   or upload your own SVG whose regions carry identifying path IDs.
2. **Associate regions with content or links.** Wire each region to the content it
   should reveal or the destination it should link to.
3. **Pick an interaction.** Choose the Navigation action to make the map a visual
   menu, the Modal Content action to pop up related content on click, or the AJAX
   loader to chain from one map to another.
4. **Add an accessible alternative.** Provide a text list of the same links and make
   sure regions have accessible names and keyboard support, so the map is usable by
   everyone.

The module notes that AI was used to modernise its codebase for Drupal 11 and to
generate its test cases.
