<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
EPT Text is the simplest member of the Extra Paragraph Types family: it ships one ready-made Paragraph type — an optional title plus a WYSIWYG rich-text body — with the family's shared design options, so a Paragraphs-based page builder gets a text component without anyone hand-building the bundle.

---

The Extra Paragraph Types project splits page building into one small module per component, all sharing `ept_core` for the design and styling options they have in common. `ept_text` contributes the text component and is almost entirely configuration: `config/install` defines a Paragraphs type `ept_text` ("EPT Text") with three fields — `field_ept_title` (a `text_long` title), `field_ept_text` (a `text_long` WYSIWYG body), and `field_ept_settings` (the shared `ept_settings` design field owned by `ept_core`) — plus its form and view displays. The module ships **no `src/`**: no routes, no permissions, no services and no PHP. The edit form (via Field Group) has two tabs, **Content** (title + text) and **Settings** (the design options). On the front end `templates/paragraph--ept-text--default.html.twig` renders the title in an `<h2>`, prints the body, and appends an inline `<style>` block that `ept_core` builds from the per-paragraph design options (margin, padding, border, border radius/color/style, background color, background image/video, edge-to-edge, container width). The title and body render through the standard `text_default` formatter, so their allowed HTML follows whichever text format the editor picked and your site's format/role policy. Site-wide defaults (primary/secondary colors, mobile/tablet/desktop breakpoints, container widths) live on the shared EPT Core settings form at **Configuration » Content authoring » Extra Block Types (EPT) settings**. Remember EPT is the **paragraph**-shaped family and EBT the **block**-shaped one: a paragraph belongs to one host entity's field, while an EBT block is placeable in a region and droppable into Layout Builder. The one-module-per-component design keeps each module tiny but means a site using ten EPT components installs ten modules, all depending on `ept_core`.

---

- Add a rich-text section to a Paragraphs-based landing page.
- Give editors a WYSIWYG text component without building a bundle by hand.
- Add an optional heading above body text with the built-in title field.
- Standardise rich-text editing across a page-builder library.
- Share background and spacing options across page components via `ept_core`.
- Put a text section on a colored background.
- Set a background image or video behind a text section.
- Add margins, padding and a border around a text block.
- Round the corners of a text section with border radius.
- Make a text section span edge-to-edge across the viewport.
- Constrain a text section to a narrower container width.
- Keep section styling in configuration instead of ad-hoc CSS.
- Override the text component's markup with the supplied Twig template.
- Combine text paragraphs with other EPT components on one page.
- Adopt one EPT component without installing the whole set.
- Apply site-wide color and breakpoint defaults from EPT Core.
- Build a marketing page from stacked, form-configured components.
- Reuse the same text component across several sites.
- Let editors control spacing and background without touching CSS.
- Migrate ad-hoc text paragraph types onto a single maintained one.
- Ship a text component that already declares Drupal 12 compatibility.
- Give a design system a canonical, reusable text block.
