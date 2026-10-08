<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Progressive Accessibility Widget adds a front-end accessibility toolbar (based on the Sienna accessibility widget) as a placeable Drupal block, offering content adjustments (font size, dyslexia font, line spacing), colour options (high contrast, monochrome) and reading aids (reading guide, enlarged cursor) — with no requests to third-party services, so it is GDPR-friendly.

---

The module is deliberately thin: it declares a `progressive_accessibility_block` block plugin, an `asw_widget` theme hook, and a library that loads the external widget's JS/CSS from `/libraries/progressive-accessibility-widget/dist/` plus a small local CSS override. The external library (>=1.0.3) is not bundled; it is installed via the Composer Merge Plugin (using the module's `composer.libraries.json`) or downloaded manually into `/libraries`. A `hook_requirements()` runtime check reports an error on the status page if the widget's JS file is missing. The block has one setting, **Widget icon**, a path to a custom launcher icon; the block's `validatePath()` accepts a Drupal-root-relative path, a public-files-relative path, or a stream-wrapper URI, and rejects absolute local filesystem paths, returning a themed widget with the resolved icon URL (or the module's default SVG).

Operationally it is a standard block: placement and configuration require Drupal's block-admin permissions, and it adds no routes, services, permissions, or callbacks of its own. All processing is client-side in the visitor's browser. Setup: install the external library, then at Structure → Block layout place "Progressive Accessibility Block" in a region and optionally set a custom widget icon.
---
- Add an accessibility toolbar to the site as a block
- Let visitors increase or decrease font size
- Offer a dyslexia-friendly font toggle
- Adjust line spacing for readability
- Enable a high-contrast colour mode
- Enable a monochrome/greyscale mode
- Provide a reading guide ruler
- Provide an enlarged cursor option
- Offer a GDPR-compliant widget that calls no third-party services
- Place the widget only on specific pages via block visibility rules
- Set a custom launcher icon for the widget
- Use a public:// stream-wrapper URI for the widget icon
- Fall back to the module's default SVG icon when none is set
- Verify the external library is present via the status report
- Install the widget library via the Composer Merge Plugin
- Install the widget library manually into /libraries
- Restrict widget placement to authenticated users via block config
- Improve WCAG compliance with user-controlled display adjustments
- Keep all accessibility processing client-side in the browser
- Theme or restyle the widget via the local CSS override
