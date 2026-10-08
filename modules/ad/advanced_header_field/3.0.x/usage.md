<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Advanced Header Field provides a heading field type that decouples a heading's semantic tag from its visual size, with an optional subtitle and an optional text-as-link.

---

Advanced Header Field adds a single-value field type (`advanced_header_field`) built on top of the core Link field. Each value stores heading text, an optional subtitle, an optional link (with an "open in new window" option), a chosen semantic tag (h2-h6), a visual size class, style classes, and an optional custom anchor id — all in one field table. The point is that an editor can render an `<h4>` that visually looks like an `<h1>` (or vice-versa) without breaking document outline for SEO and accessibility. Two formatters ship: an HTML markup formatter that wraps the heading in a `<header>` or `<div>` with BEM-style classes and a generated anchor id, and an admin-only Summary formatter that shows the tag/text and a copy-the-anchor-id button. Style class options and available semantic tags are configured per field; themes are expected to supply the actual CSS. A companion `advanced_header_field_navigation` submodule adds a jump-menu block that links to headings the editor opts in.

---

- Add a "heading + subtitle" field to a content type, block type, paragraph, or any fieldable entity.
- Let editors choose a semantic tag (h2-h6) independent of visual size.
- Render an `<h3>` that visually looks like an `<h1>` without breaking heading order.
- Add an optional subtitle line beneath a heading.
- Turn a heading into a link to an internal path, entity, or external URL.
- Force a heading link to open in a new window.
- Restrict which semantic tags editors may pick, per field (Allowed Tags setting).
- Offer editors a set of visual size classes (h1-h6) applied as `--size-*` modifier classes.
- Offer editors reusable style classes (e.g. Centered, Italic) as `--style-*` modifier classes.
- Add project-specific custom style options via the field storage "Custom Styles" textarea (`value|label` per line).
- Generate a stable in-page anchor id automatically from the heading text and parent entity id.
- Let editors override the anchor id with an SEO-friendly custom value (lowercase, digits, hyphens).
- Wrap the heading output in a semantic `<header>` element or a generic `<div>` (formatter setting).
- Hide a heading visually while keeping it for screen readers (visually-hidden option) to preserve outline.
- Provide a themeable template (`advanced-header-field.html.twig`) with a customizable BEM base class.
- Override the base class per theme via `THEME_preprocess_advanced_header_field()`.
- Show an admin-only Summary formatter listing tag + text with a button to copy the anchor id.
- Migrate legacy displays automatically: update hook renames the old `advanced_header_field_string` formatter to `advanced_header_field_summary`.
- Build page section headings for landing pages and long-form content.
- Store all heading data (text, subtitle, link, options) in a single field table for simpler queries.
- Enable the navigation submodule to add an on-page jump menu between opted-in headings.
- Give each jump-menu heading a shorter label via the Short Title option.
