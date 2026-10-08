<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple Icons adds a field that lets editors attach brand icons from the Simple Icons project, plus a Twig helper for printing those icons in templates.

---

The module defines a `simple_icons_icon` field type (a string value up to 255 chars) with a matching widget for choosing an icon and a formatter (`SimpleIconsIcon`) for rendering it. An `IconMarkup` service and a `SimpleIconsTwigExtension` expose the icon markup to Twig so themes can render an icon by name outside of a field context. Because it builds on core `field`, icons can be added to any fieldable entity (nodes, taxonomy terms, users, media, paragraphs) and displayed via the standard Field UI.

This is a display/field-types module with no routes, permissions or configuration of its own beyond field configuration; there is no HTTP surface or anonymous endpoint. Icon values are rendered as SVG/markup through the module's formatter and Twig extension. Typical setup is adding a "Simple Icons icon" field to a content type, selecting an icon per entity, and configuring the formatter on the display — or calling the Twig function directly in a template.

---

- Add a brand-icon field to a content type
- Store a Simple Icons icon reference on any entity
- Render an icon via the field formatter
- Pick an icon with the provided field widget
- Print an icon in Twig by name
- Attach icons to taxonomy terms or users
- Show social/brand icons next to content
- Reuse the same icon set site-wide
- Configure icon display in the Field UI
- Use the IconMarkup service in custom code
- Add multiple icons via a multi-value field
- Display technology/brand logos in listings
- Embed icons in custom Twig templates
- Keep icon markup consistent across themes
- Provide editors a simple icon picker
- Render icons as inline SVG markup
- Add icons to paragraphs or media entities
- Build brand link blocks with icons
- Standardise brand iconography across the site
- Combine icon fields with view modes
