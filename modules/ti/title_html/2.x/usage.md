<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Title HTML lets a content type's node title carry inline HTML markup (emphasis, superscript, line breaks, links) by storing the title in a separate formatted text field and rendering it through Drupal's text-format filter pipeline.

---

Core node titles are a plain-text base property, so a title can never contain markup such as an italicised species name, a chemical formula's subscript, or a manual line break. Title HTML works around this per content type: when you tick "Enable Title HTML Field" on a content type's edit form, the module creates a formatted `text_long` field named `title_html` on that bundle, copies existing node titles into it via a batch, swaps the plain `title` widget out of the node form for the new field, and records the field name in the node type's third-party settings (`html_title`). On display it hooks `template_preprocess_field` for the node title field and replaces the rendered value with the `title_html` field run through `check_markup($value, $format)` — the standard Drupal text-format filter system — so the markup shown is whatever the field's assigned text format permits. The module ships a purpose-built "Title" text format that allows a curated set of inline tags, and its settings form (Configuration -> Content -> Title HTML settings) selects which text format the title widget uses. Because many parts of a site expect a plain title (the HTML document `<title>`, breadcrumbs, menu links, admin content lists, search results), the module keeps the real `title` base property in sync on every save by storing a tag-stripped, entity-decoded copy of the HTML title, so those contexts stay plain text while the node page itself shows the formatted version. A CKEditor plugin and a dedicated textarea widget are bundled to make editing the title-as-markup field comfortable (optionally disabling Enter/Shift+Enter to control `<p>`/`<br>` insertion). The submodule `commerce_title_html` extends the same mechanism to Commerce product, product variation, and store titles.

---

- Allow inline HTML in a node title on a chosen content type.
- Italicise a term, book title, or Latin binomial inside a title.
- Add a superscript or subscript (formulas, ordinals, footnote marks) to a title.
- Insert a manual line break in a long title.
- Render a title through a controlled text format's allowed-tag list.
- Keep the plain `<title>` tag, breadcrumb, and menu link readable as plain text automatically.
- Enable formatted titles per content type without a code change.
- Batch-copy existing node titles into the new HTML title field when enabling.
- Swap the plain title widget for a rich textarea on the node form.
- Choose which text format drives the title field via the settings form.
- Use the bundled "Title" text format with its curated inline tag set.
- Provide editors a CKEditor toolbar for the title field.
- Disable the Enter key in the title editor to prevent stray `<p>` tags.
- Disable Shift+Enter to prevent stray `<br>` tags.
- Set a minimum auto-grow height for the title editor.
- Turn the feature off for a content type and restore the plain title field.
- Extend HTML titles to Commerce products via `commerce_title_html`.
- Add formatted titles to Commerce product variations.
- Add formatted titles to Commerce stores.
- Display a formatted store name on storefront pages.
- Keep admin product/order lists showing plain product names.
- Configure which formatted field feeds each product type's title.
- Restrict who can toggle the feature to content-type administrators.
- Uninstall cleanly, dropping the title HTML field and its third-party settings.
