CKEditor 5 Allowed HTML adds a text-format filter whose "Allowed HTML tags" list is editable again, restoring the CKEditor 4-style ability to hand-maintain which HTML tags and attributes a text format permits under CKEditor 5.

---

The module ships a single filter plugin, `filter_allowed` ("Limit allowed HTML tags and correct faulty HTML - Editable tag list"), which is a near-verbatim copy of Drupal core's `filter_html` filter with one difference: the "Allowed HTML tags" field is a normal editable textarea instead of the read-only, toolbar-derived field that core CKEditor 5 provides. Because CKEditor 5's General HTML Support (GHS) allow-list is built from a text format's filter restrictions, editing this list is a no-code way to let editors keep extra tags/attributes (custom markup, migrated CKEditor 4 markup, media/embed tags) without writing bespoke CKEditor 5 plugins. It reuses core's `Xss::filter()` for tag filtering and a DOM-based pass for attribute/value filtering, keeps the same always-stripped protections (inline `style`, `on*` event handlers, JavaScript URLs), and offers the familiar "basic HTML help" tips table and optional `rel="nofollow"` on links. Configuring the filter is part of editing a text format and therefore requires the trusted `administer filters` permission; the maintainer explicitly notes that by using it you take responsibility for manually maintaining a correct and safe tag list.

---

- Restore an editable "Allowed HTML tags" list for a text format under CKEditor 5.
- Migrate a Drupal 9 / CKEditor 4 site's extensive allowed-tags list into Drupal 10/11.
- Allow extra inline tags (e.g. `<sup>`, `<sub>`, `<abbr>`, `<cite>`) that the toolbar-derived list omits.
- Permit table markup (`<table> <tr> <td rowspan colspan> <th rowspan colspan> <thead> <tbody> <tfoot> <caption>`).
- Allow list markup with attributes such as `<ol start>`.
- Allow `<drupal-media data-entity-type data-entity-uuid alt>` embeds alongside custom tags.
- Add attributes to existing tags without adding a CKEditor plugin (e.g. `<a href hreflang>`).
- Use attribute-name wildcards like `<div data-*>` to allow families of data attributes.
- Use attribute-value wildcards like `<span class="jump-*">` to allow prefixed class values.
- Restrict an attribute to specific values (e.g. `<a href> <ol start>` vs `<td rowspan colspan>`).
- Keep `lang` and `dir` (with `ltr`/`rtl`) allowed globally for accessibility/i18n.
- Automatically add `rel="nofollow"` to every link produced by a format (spam/SEO control).
- Show a "basic HTML help" tips table beneath long filter tips for content authors.
- Configure per text format, so different formats (e.g. Basic vs Full HTML) can allow different tags.
- Pair with core's Source Editing so editors can insert the newly allowed tags directly.
- Stand up a permissive "Full HTML"-style format for a small set of trusted editorial roles.
- Correct faulty/unbalanced HTML on output (reversible transform, like core's equivalent filter).
- Replace the temporary use of core's filter: copy the tag list it recommends, then paste it here and extend it.
- Provide a stable, hand-curated allow-list that does not change as toolbar buttons are added/removed.
- Support content-model tags needed by custom themes/components that core's filter would drop.
- Enable footnotes/annotation markup or other structured inline elements a project relies on.
- Keep exported text-format config (`filter_format.*`) in version control with an explicit tag list.
