Adds a Horizontal Line button to the CKEditor 5 toolbar so editors can insert an `<hr>` divider into rich-text content.

---

The CKEditor5 horizontal line module is a thin Drupal integration of the official upstream `@ckeditor/ckeditor5-horizontal-line` CKEditor 5 plugin. It ships no PHP logic, no configuration form, no routes and no permissions — its entire job is to register a CKEditor 5 plugin definition (`ckeditor5_horizontal_line.ckeditor5.yml`) that surfaces a draggable "Horizontal Line" button in the toolbar builder of any text format that uses the CKEditor 5 editor. Once the button is on a format's active toolbar, editors can insert a horizontal rule (rendered as an `<hr>` element) to divide content into sections or signal a topic change. Because the plugin declares `elements: false`, it does not automatically widen the format's allowed HTML; a site builder using a restricted "Limit allowed HTML tags" filter must add `<hr>` to the allowed tags for the divider to survive filtering. The module depends on core's `ckeditor5` module and supports Drupal 9, 10 and 11.

---

- Enable the module (`drush en ckeditor5_horizontal_line`) to make the Horizontal Line toolbar button available to all CKEditor 5 text formats.
- Add the Horizontal Line button to the Full HTML format's toolbar at `admin/config/content/formats/manage/full_html`.
- Add the button to Basic HTML or any custom CKEditor 5 text format by dragging the horizontal-line icon into the active toolbar.
- Let content authors insert a section divider (`<hr>`) between paragraphs of a body field.
- Visually separate a change of topic in long-form articles or documentation pages.
- Break up landing-page copy edited through CKEditor 5 into distinct blocks.
- Provide editors a WYSIWYG alternative to hand-typing `<hr>` in the source-editing view.
- Insert horizontal rules in comment bodies where a CKEditor 5 format is used for comments.
- Add dividers inside custom block bodies rendered through a CKEditor 5 text format.
- Whitelist `<hr>` in a restricted text format's "Limit allowed HTML tags and correct faulty HTML" filter so inserted lines are not stripped.
- Style the inserted divider site-wide by overriding the `.ck-content hr` rule from `css/horizontal-line.css`.
- Preview the divider inside the editor, where `.ck-horizontal-line` uses `display: flow-root` to render correctly next to floated images.
- Give editors a keyboard/toolbar-driven way to structure content without leaving the rich-text editor.
- Use it alongside other CKEditor 5 plugin modules (media, code block, etc.) as part of a richer authoring toolbar.
- Standardize section breaks across a multi-author editorial team via a single shared text format.
- Provide translators a self-explanatory "Horizontal line" toolbar tooltip (string is translatable via `CKEDITOR_TRANSLATIONS`).
- Try the feature quickly on simplytest.me before adding it to a production text format.
- Migrate a CKEditor 4 "horizontal rule" workflow to CKEditor 5 by enabling this module.
- Confirm the divider survives text-format filtering by testing insert + save on a restricted format.
- Remove the feature cleanly by uninstalling the module (no config schema or data is left behind).
