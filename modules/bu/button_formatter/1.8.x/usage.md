<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Button Formatter renders link and file fields as styled buttons instead of plain anchors, with the button style chosen per field display and the set of available styles defined once for the site.

---

Turning a link or file field into a call-to-action button is a recurring need that usually gets solved badly: a class typed into the link's own attributes, a per-field template override, or a Views field rewrite — all of which scatter presentation decisions across the site. This module centralises them. A settings form at `/admin/config/button-formatter`, behind the `administer button formatter` permission (`restrict access: true`), defines the vocabulary of button-style classes (`global_class` plus `styles`, `sizes`, `radius` lists, preconfigured for Bootstrap `btn-*`). The `button_formatter` field formatter then offers those styles as a select on any `link` or `file` field's display settings, along with per-display options for an icon, opening in a new tab, forcing a file download, and a custom or description-based label. Rendering goes through a `Link` object and the `button_link` theme hook (`templates/button-link.html.twig`), so the markup is themeable. Because the style choice is part of the field display, it exports with configuration and applies consistently everywhere that display is used — including in Views, when the field is rendered through its formatter. Dependencies are core only (`^10 || ^11`); the release carries the legacy `8.x-1.8` packaging string.

---

- Render a link field as a call-to-action button.
- Style a file-download field as a button.
- Offer editors a fixed set of button styles.
- Keep button styling out of individual link attributes.
- Apply consistent CTA styling across content types.
- Match buttons to a Bootstrap or custom CSS framework.
- Choose a button style per field display.
- Add a Font Awesome icon in front of the button label.
- Force a file link to download instead of navigate.
- Open a button link in a new browser tab.
- Give a button a fixed custom label instead of the link title.
- Use a file's description text as the button label.
- Add an "external link" class to off-site buttons.
- Export button configuration with the site.
- Render buttons inside a view field.
- Avoid a per-field template override.
- Give a landing page a prominent download button.
- Distinguish primary and secondary actions by style.
- Theme all buttons through one Twig template.
- Restrict who can define the button style vocabulary.
- Style a media entity's file as a button using the media name.
- Reduce bespoke CSS for link fields.
