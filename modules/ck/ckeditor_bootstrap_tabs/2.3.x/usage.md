CKEditor5 Bootstrap Tabs adds a toolbar button to CKEditor 5 that lets content editors insert and manage Bootstrap-style tabbed content (nav-tabs + tab panes) directly inside the WYSIWYG, producing the markup Bootstrap needs to render interactive tabs on the front end.

---

The module ships a CKEditor 5 plugin (`ckeditor_bootstrap_tabs.ckeditor5.yml` → `ckeditor5-bootstrap-tabs.BootstrapTabs`) that registers a **`bootstrapTabs`** toolbar item. Once you add that button to a text format's CKEditor 5 toolbar (Manage → Text formats and editors), editors get a split button/dialog to choose the number of tabs; a context menu then lets them add a tab before/after, remove a tab, or rename a tab title, and a page can contain multiple tab widgets. The plugin emits Bootstrap tab markup — a `ul.nav.nav-tabs` list of `a.tab-link` triggers plus a `div.tab-content` of `div.tab-pane` panels with the roles/attributes Bootstrap expects — and the format's filter must allow those elements (the plugin declares the elements it needs). On the rendered page, `hook_page_attachments()` loads the module's `tabs` library (`js/tabs.js` + `css/tabs.css`) so the tabs are interactive for visitors, while an editing/admin library styles the widget inside CKEditor. The module depends only on `ckeditor5`; it has no settings form, config entity, permissions, Drush commands, or PHP configuration — all configuration is done by editing the CKEditor 5 toolbar/allowed-tags of a text format. It does not itself load Bootstrap's CSS framework; your theme is expected to provide the Bootstrap tab styles/behavior (the bundled `tabs.js`/`tabs.css` provide the switching).

---

- Let editors insert Bootstrap-style tabbed content in the WYSIWYG without writing HTML.
- Add a "Bootstrap Tabs" button to a rich-text format's CKEditor 5 toolbar.
- Create multi-tab sections (e.g. Description / Specs / Reviews) inside a node body.
- Choose the number of tabs when inserting a tab widget.
- Add a tab before or after the current one via the context menu.
- Remove a tab from an existing tab set.
- Rename a tab's title inline.
- Place multiple independent tab widgets on the same page.
- Produce Bootstrap-compatible `nav-tabs` / `tab-content` / `tab-pane` markup automatically.
- Enable tabbed FAQ or documentation layouts for content authors.
- Keep tab markup consistent across editors instead of hand-coded HTML.
- Provide interactive tabs on the front end via the bundled tabs library.
- Build product pages with tabbed information blocks.
- Offer editors a structured alternative to accordions for grouping content.
- Add tabs inside any entity using a CKEditor 5-backed text field (nodes, blocks, paragraphs).
- Restrict tab editing to specific formats by only adding the button to those toolbars.
- Ensure allowed HTML tags include the tab elements so the markup survives filtering.
- Author tabbed content that a Bootstrap-based theme renders natively.
- Give non-technical authors a click-driven tab builder.
- Reduce support requests for "how do I make tabs" by exposing a toolbar tool.
- Combine tabs with other CKEditor 5 content within the same field.
