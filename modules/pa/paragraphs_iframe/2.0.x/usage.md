<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Paragraphs Iframe is a configuration-only add-on for the Paragraphs module that provides a pre-built "iframe" paragraph type with a required Source link field.

---

Rather than shipping code, the module installs a Paragraphs type (`paragraphs.paragraphs_type.iframe`) plus a `link`-type field `field_iframe_source` and its form/view displays as optional config. The `.module` file is effectively empty. Once enabled and (as needed) the optional config imported, editors gain an "iframe" paragraph they can add to any paragraph-referencing field to capture the source URL of external content they want to embed.

Because the shipped display uses the core **link** field type and the core **link** formatter (`type: link`), the Source value is rendered as a standard, core-sanitized link — the module itself does not build or output any `<iframe>` markup or raw attributes, so there is no custom XSS sink in this version. If you want the value rendered as an actual embedded iframe, you provide the theming/formatter yourself. Typical setup: enable Paragraphs and this module, import the optional config to get the iframe type and field, then reference the iframe paragraph from a content type's paragraph field.
---
- Add a ready-made "iframe" paragraph type without hand-building fields
- Give editors a Source link field to capture embed URLs
- Reference the iframe paragraph from any paragraph field
- Standardize how embed sources are stored across content
- Reuse the same iframe paragraph across multiple content types
- Provide a starting point for a themed iframe embed component
- Store external content URLs as validated link values
- Keep embed configuration in exportable config
- Combine with other Paragraphs types in a layout
- Localize the iframe paragraph (language dependency declared)
- Import the optional field/display config on install
- Extend the paragraph with a custom formatter to render an actual iframe
- Capture video/map/document embed URLs from editors
- Avoid custom code for a simple embed-source field
- Add the iframe paragraph to a landing-page paragraph field
- Export the iframe type and field between environments
- Require editors to supply a source URL (field is required)
