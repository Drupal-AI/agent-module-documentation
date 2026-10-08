<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SVG Pan Zoom adds an image-field formatter that displays SVG images inside the svg-pan-zoom JavaScript library so viewers can drag to pan and scroll/double-click to zoom.
---
The module registers a `svg_pan_zoom` field formatter (extends core's ImageFormatter) for `image` fields. All svg-pan-zoom behaviours — panEnabled, zoomEnabled, mouseWheelZoomEnabled, min/max zoom, zoomScaleSensitivity, fit, contain, center, refreshRate — are exposed as formatter settings and passed to the JS via `data-*` attributes on the rendered element. A `display` setting chooses between `embed` (an `<embed type="image/svg+xml">` pointing at the file URL) and `inline` (the SVG file's contents are read with `file_get_contents()` and printed directly into the page markup).

It depends on the contrib `svg_image` module (so image fields accept SVG uploads) and on the external `svg-pan-zoom` library (3.6.1+), which must be installed into the site's libraries directory. Setup is done per view-display on Manage Display.
---
- Install the svg-pan-zoom library into libraries and enable the module.
- Add an image field to a content type that accepts SVG (via svg_image).
- Set the field's display formatter to "Svg Pan Zoom".
- Enable pan on an interactive diagram field.
- Enable mouse-wheel zoom for schematic images.
- Disable zoom while keeping pan only.
- Turn on double-click-to-zoom for touch-friendly viewing.
- Set min/max zoom bounds for a map SVG.
- Tune zoomScaleSensitivity for finer zoom steps.
- Enable control icons (on-screen zoom buttons).
- Fit and center the SVG within its container on load.
- Use `contain` sizing for oversized vector art.
- Set explicit width/height on the rendered SVG element.
- Choose `embed` display for sandboxed, safer SVG rendering.
- Choose `inline` display to allow CSS styling of SVG internals.
- Render an architectural floor-plan field with pan/zoom.
- Present interactive infographics from an SVG upload.
- Show zoomable circuit or network diagrams.
- Configure refreshRate for animation-heavy SVGs.
- Combine with image styles inherited from the base ImageFormatter.
