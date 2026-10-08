Bootstrap Utilities provides four text-format filters that automatically add Bootstrap CSS classes to the HTML a text format produces — `.table` on tables (with optional striped/bordered/hover/small variants), `.img-fluid` on images, `.blockquote` on block-quotes, and `.figure`/`.figure-caption` on figures — so editor content styles correctly under a Bootstrap 4/5 theme without editors touching markup.

---

The module ships four Filter plugins (each a normal core `filter` plugin, configured per text
format at *Configuration → Content authoring → Text formats and editors*): **Table Classes**
(`bootstrap_utilities_table_filter`), **Blockquote Classes** (`bootstrap_utilities_blockquote_filter`),
**Figure Classes** (`bootstrap_utilities_figure_filter`), and **Responsive Image Class**
(`bootstrap_utilities_image_filter`). Each filter loads the text through `Html::load()` and uses
**xPath** (no regular expressions, for performance) to find the relevant elements and merge in the
Bootstrap class(es): the image filter adds `img-fluid` to every `<img>`; the blockquote filter adds
`blockquote` to every `<blockquote>`; the figure filter adds `figure` to `<figure>` and
`figure-caption` to `<figcaption>`. The table filter always adds `table` and, based on its own
settings, optionally `table-striped`, `table-bordered`, `table-hover`, and `table-sm`, and can strip
`width`/`height` attributes from `<tbody>` cells for responsiveness. Only the table filter has a
settings form (and a config schema, `filter_settings.bootstrap_utilities_table_filter`); the other
three are on/off. Existing classes on an element are preserved (the new class is merged, not
replaced). The filters are `TYPE_TRANSFORM_IRREVERSIBLE`, so order them sensibly with other filters
in the format. Depends only on core `filter`; no permissions, routes, services, or Drush.

---

- Automatically add Bootstrap's `.table` class to editor-created tables so they pick up theme styling.
- Turn on zebra-striping for content tables with the `.table-striped` option.
- Add hover highlighting to table rows via the `.table-hover` option.
- Add cell borders to content tables with the `.table-bordered` option.
- Make content tables compact with the `.table-sm` option.
- Strip hard-coded `width`/`height` attributes from pasted tables so they render responsively.
- Make all images in rich-text fields responsive by adding `.img-fluid` automatically.
- Apply Bootstrap `.blockquote` styling to quotes entered in CKEditor.
- Style figures and their captions with `.figure` / `.figure-caption` classes.
- Keep editor markup clean — editors write plain HTML and the theme classes are added on output.
- Standardise Bootstrap styling across all content without a custom CKEditor plugin.
- Enable only the filters you need per text format (e.g. tables on "Full HTML", images on "Basic HTML").
- Preserve any manually-added classes on an element while still adding the Bootstrap class.
- Ensure migrated/imported HTML content gets Bootstrap classes on render.
- Provide consistent responsive images across a Bootstrap 5 site without editing each image.
- Configure different table styling per text format (striped on one, bordered on another).
- Avoid regex-based markup rewriting by using the module's xPath-based, performance-friendly filters.
- Let a WYSIWYG produce semantic HTML while the theme layer (via filters) handles Bootstrap classes.
- Apply Bootstrap table styling to third-party/embedded HTML rendered through a filtered text format.
- Roll out a Bootstrap theme to an existing site and instantly style legacy body content.
- Combine with core filters (e.g. "Limit allowed HTML tags") in a deliberate filter order.
