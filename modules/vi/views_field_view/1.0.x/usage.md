Views Field View adds a "Global: View" field handler to Views, letting you embed one view as a field inside another and pass argument (contextual filter) values from the parent row into the embedded child view.

---

Views Field View implements `hook_views_data_alter()` to register a single Views field plugin (`@ViewsField("view")`) exposed in the UI as "Global: View". You add this field to a "parent" view; it renders a chosen display of a "child" view once per parent row. The field's "Contextual filters" setting takes a comma- or forward-slash-separated list of replacement tokens that map parent fields and arguments onto the child view's contextual filters, so each parent row drives what the child shows. Tokens come in four flavours generated from the parent display's handlers: `{{ raw_fields.FIELD }}` and `{{ fields.FIELD }}` (raw vs. rendered field value) and `{{ raw_arguments.ID }}` / `{{ arguments.ID }}` (raw vs. titled argument value); values that match no token are passed through as static arguments. Because rendering happens in field order, only fields placed above the View field can be used as tokens, and each token field should be output clean (no label or extra markup). The child view is loaded with `Views::getView()`, checked with `access()`, then previewed per row, with per-row pager IDs rewritten so multiple embedded pagers don't collide. Recursion is guarded: a view embedding itself renders "Recursion, stop!" unless the module's `evil` config flag is enabled. A small config object (`views_field_view.settings`, key `evil`, default `false`) is the module's only setting; there is no admin settings form, no permissions, and no public service API.

---

- Embed a related-content view inside another view, one instance per parent row.
- Show each author's most recent articles beside the author in an author listing.
- List a taxonomy term's tagged nodes under each term in a terms view.
- Display a product's variations or related products within a product row.
- Build master/detail listings (orders with their line items) in a single view.
- Pass a parent node ID into a child view's contextual filter via `{{ raw_fields.nid }}`.
- Forward a taxonomy term ID from the parent row to filter a child view.
- Pass a rendered field value to the child using a `{{ fields.FIELD }}` token.
- Forward a parent view's argument to the child with `{{ arguments.ID }}` / `{{ raw_arguments.ID }}`.
- Pass multiple arguments by separating tokens with commas or forward slashes.
- Pass a static ID or taxonomy term string as a fixed argument to the child view.
- Choose which display of the child view to embed (default, a page, a block, an attachment).
- Reuse one child view across many parent views by feeding it different arguments.
- Create nested/hierarchical listings without writing a custom Views field plugin.
- Hide the embedded output when the child view has no results (hide empty).
- Keep parent and child pagers independent thanks to per-row pager ID rewriting.
- Restrict embedded output to users who pass the child display's access check.
- Rearrange fields so argument-source fields sit above the "Global: View" field.
- Mark argument-source fields as "Exclude from display" while still using them as tokens.
- Guard against infinite recursion when a view would embed itself ("Recursion, stop!").
- Enable the `evil` setting deliberately to allow recursive embedding in special cases.
- Enable Views caching on embedded displays to offset the extra per-row queries.
- Link straight to the child view's edit page from the parent field settings form.
- Export the embedded-view field configuration as part of the parent view's config.
