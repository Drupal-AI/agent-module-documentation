<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor Div Manager adds a **Div Manager** toolbar button to CKEditor 5 that lets editors wrap content in a `<div>` container, optionally setting its class, id, title, lang and inline style through a small pop-up form.

---

The module is a pure CKEditor 5 (JavaScript) plugin integration for Drupal — it ships no PHP, no config schema, no permissions, no Drush and no `configure` route. Its `ckeditor_div_manager.ckeditor5.yml` registers one CKEditor 5 plugin (`divManagerPlugin.DivManager`), one toolbar item **`DivManager`** (label "Div Manager"), and declares the elements it grants: `<div>` and `<div class="simple-box-description">`. The built JS (`js/build/divManagerPlugin.js`, source under `js/ckeditor5_plugins/divManagerPlugin/`) defines a CKEditor model element `divContent`, upcasts `<div class="simple-grid">` into that model, and downcasts it back to a `<div>` carrying whatever `class`, `id`, `title`, `lang` and `style` attributes were entered. Clicking the toolbar button opens a contextual balloon form (content text, title, id, class, langcode, raw styles); submitting runs the editor command `addDiv`, which inserts a `divContent` element with those attributes. You enable it per text format on *Administration → Configuration → Content authoring → Text formats and editors* by dragging the Div Manager button into the CKEditor 5 toolbar; if "Limit allowed HTML tags" (filter_html) is on, the format must permit at least `<div>` (and `<div class id title>` for the extra attributes). Note the module ships a legacy Composer requirement on the CKEditor 4 `div` library group, but the 3.0.x plugin is self-contained CKEditor 5 build output.

---

- Add a Div Manager button to the Full HTML editor so editors can wrap sections in a `<div>`.
- Let content authors group several blocks of content inside one container div.
- Insert a styled wrapper such as `<div class="callout">` around a paragraph without editing source.
- Apply a CSS grid/layout class (e.g. `simple-grid`) to a block of rich-text content.
- Give a container an `id` so it can be targeted by an in-page anchor or JavaScript.
- Set a `title` attribute on a div for tooltip/accessibility purposes from the WYSIWYG.
- Add a `lang` attribute to a div to mark a passage in another language.
- Attach inline styles to a container region directly from the editor dialog.
- Provide non-technical editors a UI alternative to hand-writing `<div>` markup in Source view.
- Standardise wrapper markup across a site by teaching editors one button.
- Enable div containers only on selected text formats while keeping others locked down.
- Combine with the format's Styles dropdown so defined div classes carry into the pop-up.
- Wrap promotional content in a branded container class for consistent styling.
- Create a "simple box" description block inside body content.
- Let editors build simple multi-column layouts using container divs plus CSS.
- Add semantic grouping divs required by a theme's component CSS.
- Allow editors to add ARIA/role-friendly container elements via attributes.
- Round-trip existing `<div class="simple-grid">` markup so it re-opens as an editable container.
- Give a marketing team a reusable container-insertion tool without a full page builder.
- Keep container markup valid by pairing the button with an explicit `<div>` filter allow-list.
