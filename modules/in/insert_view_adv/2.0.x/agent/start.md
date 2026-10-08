# Advanced Insert View — agent index

Embed a Views display inside rich-text content, via a `[view:name=display=args]` token or a
CKEditor 5 button/dialog. Rendered through cache-friendly render placeholders. No admin config
route — it is a **text-format filter** configured per format.

- **Enable & configure the filter on a text format; the CKEditor 5 plugin settings** →
  [configure/filter-and-ckeditor.md](configure/filter-and-ckeditor.md)
- **Embed syntax (`[view:...]`, `<drupal-view>`) and how `InsertView::build()` renders it** →
  [api/token-syntax.md](api/token-syntax.md)

Key facts:
- Filter plugin id: `insert_view_adv` ("Advanced Insert View"). `configure` = null.
- Depends on `views`, `editor`, `filter`.
- Filter settings: `allowed_views` (whitelist of `view=display`; empty = all), `render_as_empty`
  (int), `hide_argument_input` (bool). CKEditor plugin config: `ckeditor.plugin.insert_view_adv`
  → `enable_live_preview` (bool).
- Enabled state lives in `filter.format.<format>` → `filters.insert_view_adv.status: true`.
- **Security:** grant this filter to trusted formats only; every embeddable view/display must
  have correct Views access.
- Submodule `insert_view_adv_bueditor` adds the same button to BUEditor (requires the
  `bueditor` contrib project, which is **not installed** on this site).
