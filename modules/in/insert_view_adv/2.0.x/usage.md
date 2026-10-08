Advanced Insert View lets editors embed a Views display inside rich-text (body) content, either by typing a `[view:name=display=args]` token or by using its CKEditor 5 toolbar button and dialog. It renders the view through Drupal render placeholders so it stays cache-friendly and BigPipe-compatible.

---

The core is a text-format filter plugin (`@Filter` id `insert_view_adv`, "Advanced Insert View", TYPE_TRANSFORM_IRREVERSIBLE). Its `process()` recognises three embed syntaxes: the classic `[view:name=display=args]` token, a legacy JSON blob from the 1.x CKEditor plugin, and the current `<drupal-view data-view-id data-display-id data-arguments>` tag. For each it emits a render **placeholder** calling `InsertView::build()`, which loads the view, checks the current user's access to that display, sets contextual-filter arguments (falling back to default/exception argument values), and returns `$view->preview()` — placeholders let the surrounding entity cache independently and work with BigPipe. Filter settings are `allowed_views` (a whitelist of `view=display` keys; empty = all allowed), `render_as_empty` (if off, a disallowed view is left as its raw token), and `hide_argument_input` (block user-supplied contextual arguments). A bundled CKEditor 5 plugin (`insert_view_adv`, config `ckeditor.plugin.insert_view_adv` with `enable_live_preview`) adds a toolbar button and a dialog that lists views/displays and their contextual filters (with entity-reference autocomplete). Because embedding a view is powerful, the filter should be granted only to trusted text formats/roles, and every embeddable view/display must have correct Views access. The submodule `insert_view_adv_bueditor` adds the same capability to the BUEditor editor. There is no admin config route (`configure` = null); everything is configured per text format at *Configuration → Content authoring → Text formats and editors*.

---

- Embed a "Latest articles" view block inside a page's body text.
- Drop a filtered product listing into a landing page's rich text.
- Insert a view with a contextual argument, e.g. `[view:tracker=page=1]`.
- Add a view via the CKEditor toolbar button without typing tokens.
- Pick the view, display and contextual-filter values from a dialog.
- Use entity-reference autocomplete to supply a contextual filter's target id.
- Restrict which views may be embedded per text format via `allowed_views`.
- Allow all views in a trusted format by leaving `allowed_views` empty.
- Prevent editors from supplying contextual arguments with `hide_argument_input`.
- Leave a disallowed view's token visible (or hidden) via `render_as_empty`.
- Embed a slideshow/carousel view into a CMS page.
- Show a related-content view inside an article body.
- Reuse a single view across many nodes' body fields.
- Keep embedded views cacheable and BigPipe-friendly via render placeholders.
- Insert a view's default display by omitting the display id in the token.
- Provide multiple arguments to a view with a slash-separated args segment.
- Embed a map/geofield view inside descriptive text.
- Add a promotions view to a marketing page through the WYSIWYG.
- Migrate legacy `[view:...]` tokens from the old Insert View module.
- Grant the embed capability only to editors via the format's role permissions.
- Preview the embedded view live in CKEditor when `enable_live_preview` is on.
- Embed the same view with different arguments on different pages.
- Add a "featured events" view to the homepage body.
- Use `<drupal-view>` tags produced by the CKEditor plugin in stored markup.
