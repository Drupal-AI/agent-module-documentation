# highlight.js Input Filter — agent index

A single text-format filter (`filter_highlightjs`) that attaches the highlight.js library +
`drupalSettings` when content has `<pre><code class="language-*">` blocks; highlighting runs
client-side in `js/highlightjs_input_filter.js`. It does NOT transform the code markup itself.
Depends only on core. One permission, one settings form, config schema, no Drush, no plugin types.

- **Enable the filter, choose theme, CDN vs self-hosted, copy button, permission** →
  [configure/filter.md](configure/filter.md)

Key facts:
- Filter id `filter_highlightjs` (`TYPE_TRANSFORM_REVERSIBLE`), class
  `Plugin/Filter/HighlightJs.php`. Enable it on a text format's *Text formats and editors* page.
- Settings config `highlightjs_input_filter.settings` (keys: `enable_copy_button`, `theme`,
  `use_local`, `local_path`, `local_path_copy`); form route
  `highlightjs_input_filter.settings.form` at `admin/config/content/highlightjs_input_filter`.
- Permission: `administer highlightjs_input_filter settings`.
- Default assets: highlight.js **11.11.1** and highlightjs-copy **1.0.6** from unpkg.com;
  self-host overrides via `hook_library_info_build` / `hook_library_info_alter`.
