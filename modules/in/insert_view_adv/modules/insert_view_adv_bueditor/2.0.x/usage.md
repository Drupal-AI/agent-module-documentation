Advanced Insert View BUEditor Integration adds a "Views Embed" button to the BUEditor editor's toolbar, letting editors insert an Advanced Insert View token (`[view:...]`) through a dialog instead of typing it by hand. It is the BUEditor counterpart to the CKEditor 5 button that ships with Advanced Insert View.

---

This submodule is a thin glue shim between `insert_view_adv` and the contrib `bueditor` editor. It defines a single BUEditor plugin (`@BUEditorPlugin` id `drupalviews`, label "Embedded Views", class `DrupalViews` extending `BUEditorPluginBase`) that contributes a `drupalviews` toolbar button ("Views Embed"). When that button is present on a BUEditor toolbar, `alterEditorJS()` attaches the `insert_view_adv_bueditor/drupalviews` JS library (which depends on `bueditor/drupal.bueditor`); the JS (`bueditor.drupalviews.js`) opens a "View Embed Token" dialog to build the token, which the parent `insert_view_adv` filter then renders. It has no config, routes, permissions, services or schema of its own. It requires both `insert_view_adv` and the separate `bueditor` project. On this documentation site the `bueditor` project is **not installed**, so this submodule cannot be enabled here.

---

- Add a "Views Embed" button to a BUEditor toolbar for embedding views.
- Give BUEditor users the same view-embedding capability CKEditor users get.
- Insert a `[view:name=display=args]` token through a dialog instead of typing it.
- Build the view-embed token via a small form (view name, display, arguments).
- Offer view embedding to sites that standardise on BUEditor rather than CKEditor.
- Keep the BUEditor integration optional and separate from the core filter.
- Provide a toolbar-driven UX for the Advanced Insert View filter under BUEditor.
- Let editors avoid memorising the `[view:...]` token syntax.
- Reuse the parent module's filter/rendering pipeline from within BUEditor.
- Enable the button only on toolbars where view embedding is wanted.
- Demonstrate how to write a BUEditorPlugin that attaches a JS library conditionally.
- Serve as a template for other BUEditor toolbar-button integrations.
- Add view embedding to a legacy BUEditor-based editing workflow.
- Pair a BUEditor toolbar with the insert_view_adv text-format filter.
- Insert views into content for editors who prefer BUEditor's lightweight UI.
