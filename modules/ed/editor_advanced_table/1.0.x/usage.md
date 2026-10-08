Editor Advanced Table adds a CKEditor 5 table toolbar button that lets editors set a CSS class, an id, and a text-direction (dir) attribute on tables.

---

The module ships one configurable CKEditor 5 plugin (`editor_advanced_table_table_advanced`, class `Drupal\editor_advanced_table\Plugin\CKEditor5Plugin\TableAdvanced`) that recreates CKEditor 4's "Advanced" table tab. It registers a `tableAdvanced` button into CKEditor 5's table content toolbar; clicking it opens a balloon form ("Advanced table properties") with up to three fields — Id, Language Direction (LTR/RTL/Not set), and Stylesheet Classes — that write the `id`, `dir`, and `class` attributes onto the selected table. Which fields appear is set per text format on the "Advanced table" plugin-settings tab (`allow_id`, `allow_language_direction`, `allow_classes`, all default TRUE). The plugin declares the `<table class id dir>` elements so those attributes survive the text format's HTML restrictions, and depends only on core's `ckeditor5` and the core table plugin. It is enabled by adding the button to a format's toolbar (or simply relying on the table content toolbar) at Administration → Configuration → Content authoring → Text formats and editors. No routes, permissions, services, or Drush commands are added.

---

- Give editors a styled table by adding Bootstrap-style classes such as `table table-striped table-bordered`.
- Add a stable `id` to a table so it can be linked to with an in-page anchor.
- Target a specific table from custom CSS or JavaScript by its `id`.
- Mark a table as right-to-left (`dir="rtl"`) for Arabic, Hebrew, or Farsi content.
- Force left-to-right (`dir="ltr"`) direction on a table inside an otherwise RTL page.
- Apply a theme's utility classes (e.g., `is-fullwidth`, `pricing-table`) to editor-created tables.
- Restore CKEditor 4 "Advanced tab" table workflows after migrating a site to CKEditor 5.
- Let content authors add a class hook so JavaScript table plugins (sorting, filtering) can attach to their tables.
- Add a semantic class such as `data-table` used by print or PDF stylesheets.
- Limit editors to only CSS classes by disabling the Id and Language Direction fields for a text format.
- Allow only an `id` on tables (for anchors) while hiding class and direction controls.
- Offer language-direction control only, for multilingual editorial teams.
- Namespace tables with an `id` so multiple tables on one page can be deep-linked from a table of contents.
- Style comparison/pricing tables consistently by applying a shared CSS class.
- Give responsive-wrapper classes to tables so a theme can make them horizontally scrollable on mobile.
- Tag tables with a class picked up by a cookie/consent or lazy-load script.
- Keep editor-added table classes and ids intact through save/reload because the module registers the matching upcast/downcast converters.
- Standardize accessible table markup by having editors apply a documented class per content type.
- Provide per-format editorial policies: strict formats expose no advanced attributes, rich formats expose all three.
- Add direction metadata to tables embedded in translated nodes without editing raw HTML source.
- Attach analytics or interaction hooks to specific tables via a unique `id`.
- Let designers hand editors a small set of class names to reuse for consistent table styling.
- Distinguish header/summary tables from data tables using different CSS classes.
- Clear an attribute again by emptying the field — the plugin removes the attribute when the value is blank.
