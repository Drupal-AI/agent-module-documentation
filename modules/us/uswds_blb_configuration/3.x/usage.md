<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
USWDS Layout Builder Configuration brings the U.S. Web Design System (USWDS) responsive grid and component styling into Drupal's core Layout Builder.

---

Install with `composer require drupal/uswds_blb_configuration` (it pulls in `media_library_form_element`) and enable it with Layout Builder and Media Library; the module ships nine breakpoints and twelve column layouts (`blb_col_1`–`blb_col_12`) as default configuration. Manage everything under **Configuration → Content → USWDS Layout Builder** (`/admin/config/uswds-layout-builder`), which needs the **Configure USWDS Layout Builder** permission: define **Breakpoints**, **Layouts** and per-layout **Options** (column splits like 25/75), pick which style plugins are available for **Sections** and **Blocks**, and set global options (hide section settings, live preview, responsive preview, one-column class) plus **Style settings** (light/dark Layout Builder theme, background/text colour lists, spacing/border/shadow options, and the media bundle+field used for background images and local video). In the Layout Builder UI you then get USWDS layouts under the **USWDS** category and, on each section and block, a **Style** tab exposing background colour/media, text colour and alignment, padding/margin, border, box-shadow and scroll effects; choices are stored on the section/component and rendered by applying USWDS CSS classes (and background media) to the markup. The optional `uswds_blb_configuration_media_library` submodule restyles the media-library widget on Layout Builder pages but is flagged unstable by its maintainers.

---

- Install via `composer require drupal/uswds_blb_configuration`.
- Enable alongside Layout Builder and Media Library.
- Grant the "Configure USWDS Layout Builder" permission to site builders.
- Enable Layout Builder on a content type's view display.
- Add USWDS layouts (category "USWDS") to a section.
- Choose a column layout from `blb_col_1` through `blb_col_12`.
- Pick a column-split option (e.g. 25/75, two equal columns) per section.
- Define custom breakpoints with their own grid base class.
- Create new layouts and layout options for custom grids.
- Toggle which style plugins appear on sections vs. blocks.
- Style a section: background colour, media, spacing, border, shadow.
- Style an individual block via its "Style" tab.
- Set text colour and text alignment on sections/blocks.
- Add scroll/animation effects (optionally with a local AOS library).
- Configure a background image via a mapped media bundle and field.
- Configure a local background video via a mapped media bundle and field.
- Switch the Layout Builder editing UI between light and dark themes.
- Enable live preview and responsive preview while editing.
- Restrict the block Style tab to specific block types.
- Set a custom CSS class for one-column layouts.
- Build USWDS-compliant federal/government site layouts.
- Extend styling by adding your own `@Style` / `@StylesGroup` plugins.
- Optionally enable the media-library submodule (marked unstable).
- Export the grid and style configuration with your site config.
- Review breakpoints, layouts and options after major upgrades.
