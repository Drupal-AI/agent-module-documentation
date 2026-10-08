Adds a CKEditor 5 toolbar button that wraps text into responsive, flexbox-based multi-column sections whose stacking is configured per breakpoint through an in-editor modal.

---

CKEditor 5 Column Layout is a client-side editor plugin (a Drupal CKEditor 5 plugin, not a standalone JS library) that lets authors insert a "Columns" widget into rich-text fields. Each column section is a `div.cl-flex-row` holding one or more `div.cl-flex-col` children; the row carries `data-xs`, `data-sm`, `data-md`, and `data-lg` attributes (each an integer 1-6) that a bundled CSS library turns into a flexbox grid so the columns reflow at mobile, tablet, laptop, and desktop widths. A "Settings" gear opens a Drupal AJAX modal (a `FormBase` served at `/admin/ck5-column-layout/settings`) to pick the per-breakpoint column count, and an "Add Column"/"Delete" control set manages the section in place. A companion text-format filter (`filter_ck5_column_layout`) and a `hook_entity_presave` implementation strip the editor-only UI markers from stored/output HTML and attach the responsive CSS. The module depends only on core `ckeditor5` and ships no config entities or Drush commands; the in-editor controls and the settings modal are gated by the `ck5 column layout settings` permission.

---

- Build a two-column "text + sidebar" section inside a body field without writing HTML.
- Create a three- or four-column feature row on a landing page authored in CKEditor 5.
- Let editors choose how a column row collapses on phones (e.g. 1 column) versus desktop (e.g. 4).
- Give marketing authors a WYSIWYG way to lay out responsive content blocks in node bodies.
- Add side-by-side comparison columns within an article without a dedicated Layout Builder section.
- Insert up to six columns in a single row for a footer-style link grid inside rich text.
- Restack columns 2-up on tablets and 4-up on wide monitors using the breakpoint modal.
- Provide a controlled column tool that only trusted roles (with the permission) can operate.
- Wrap pull-quotes or callouts beside body copy in a responsive column pair.
- Author multi-column CTA rows in a custom block's rich-text field.
- Give an existing Full HTML format a column builder without adding an external CKEditor build.
- Clean editor-only control markup out of saved content automatically via the bundled filter.
- Attach the responsive column CSS to the front end only when column markup is present.
- Reconfigure an existing column row's breakpoints later by reopening its Settings modal.
- Delete an individual column or an entire section with in-editor buttons.
- Standardize responsive column markup (class + data-attribute based) across a content team.
- Add columns to WYSIWYG email/newsletter body content that must degrade gracefully on mobile.
- Offer a lightweight alternative to Layout Builder for in-field, inline column arrangements.
- Constrain column counts to a safe 1-6 range enforced both in the modal and the output filter.
- Enable the tool per text format so only chosen formats expose the Columns button.
