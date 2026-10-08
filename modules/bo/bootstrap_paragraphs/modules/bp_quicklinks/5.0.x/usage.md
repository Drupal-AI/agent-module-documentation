<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bootstrap Paragraphs Quicklinks ships a single config-only Paragraph bundle, `bp_quicklinks`, that renders an unlimited list of links as a styled flex grid of "quicklink" tiles.

---

The module is a thin, config-only shim on top of Bootstrap Paragraphs: it has no plugins, no services, no settings form and no configure route, and its only PHP is a `hook_theme()` registration plus a `hook_help()` that prints its README. Installing it imports one paragraph type (`bp_quicklinks`, label "Quicklinks") along with four field instances — the shared Bootstrap Paragraphs styling fields `bp_header` (string), `bp_width` and `bp_background` (both `list_string` option lists reusing the parent's storages) — and its own field storage `paragraph.bp_quick_link`, a `link` field with `cardinality: -1` (unlimited) and `link_type: 17` (internal or external URLs) with an optional link title. The default form display renders `bp_quick_link` with the `link_attributes` widget from the contrib Link attributes module, with only the `target` and `rel` attributes enabled out of the box; the other supported attributes (`id`, `name`, `class`, `accesskey`, `aria-label`) ship disabled. The default view display uses the plain `link` formatter, but the bundle's twig template `paragraph--bp-quicklinks.html.twig` overrides the markup entirely: it attaches the `bootstrap_paragraphs/bootstrap-paragraphs` and `bp_quicklinks/bp-quicklinks` libraries, maps the `bp_width`/`bp_background` values straight through as CSS classes, prints `bp_header` in an `<h2>`, and loops the link items into `<li class="quicklink quicklink-N">` inside `<ul class="quicklinks quicklinks-<paragraph id>">`. Nothing is exposed to editors until you add an *Entity reference revisions / Paragraphs* field to a content type and tick the Quicklinks bundle in its `target_bundles`. Because the config lives in `config/optional`, all of it is imported at install time and left editable afterwards — you own it, and uninstalling the module does not remove it.

---

- Build a "Helpful resources" tile grid at the bottom of a landing page.
- Add a row of quick navigation shortcuts to a department or program page.
- Give editors a repeatable link-list component without writing a custom block.
- Create a "Popular downloads" section with links to files or documents.
- Render a set of call-to-action links styled as cards rather than a bulleted list.
- Add a set of related-site links that open in a new tab using the widget's `target` attribute.
- Set `rel="noopener noreferrer"` per link from the editing form via the Link attributes widget.
- Mix internal node references (`/node/12`, `entity:node/12`) and external URLs in one list.
- Provide a "Quick links" sidebar component inside a Bootstrap Paragraphs column layout.
- Constrain a quicklinks block to a narrow measure with the `paragraph--width--narrow` value.
- Give the quicklinks block a brand background using `paragraph--color paragraph--color--primary`.
- Nest a Quicklinks paragraph inside a `bp_columns` or `bp_column_wrapper` paragraph.
- Turn an existing hand-coded list of links in a body field into structured, translatable content.
- Let editors reorder links by dragging rows in the unlimited-cardinality link field.
- Add per-link `aria-label` values by enabling that attribute on the widget for accessibility.
- Add a CSS hook per link by enabling the widget's `class` attribute and theming from it.
- Give each quicklinks block its own anchor target via the template's `quicklinks-<pid>` class.
- Provide a consistent "jump links" pattern reused across many content types.
- Build a partner/affiliate logo-and-link strip themed off the `.quicklink` markup.
- Restrict a dedicated paragraphs field to only the Quicklinks bundle for a locked-down page template.
- Offer an editorial "footer links" component managed as content rather than as menu config.
- Migrate a legacy link-list field into a paragraph-based component with styling options.
- Translate link titles per language using the translatable `bp_quick_link` storage.
- Prototype a Bootstrap card-like link grid without writing any CSS (the module ships its own).
- Add a "Related policies" block to a governance page with an optional header.
- Give a campaign page a set of tracked outbound links with custom `rel` values.
- Replace a Views block of manually curated links with editor-managed paragraph content.
