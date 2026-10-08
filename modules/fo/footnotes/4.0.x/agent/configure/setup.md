# Set up footnotes on a text format / editor

Footnotes has **no configure route**. You enable it per **text format** by (a) turning on the
`filter_footnotes` filter and (b) adding the **Footnotes** button to that format's CKEditor 5
toolbar. Both live in the format's config.

## Option A — use the shipped "Footnote" format

The module ships two **optional** config files (installed only if absent):

- `filter.format.footnote` — a "Footnote" text format (filter_html + `filter_footnotes`;
  note `filter_footnotes.status` ships `false`, so enable it).
- `editor.editor.footnote` — a CKEditor 5 editor bound to that format.

Enable the filter on it:

```bash
drush cset filter.format.footnote filters.filter_footnotes.status true -y
```

Then add the `footnotes` toolbar item (see Option B step 2) if not already present.

## Option B — add footnotes to an existing format (e.g. Full HTML)

1. **Enable the filter.** *Administration → Configuration → Content authoring → Text formats
   and editors → (format) → Configure*, tick **Footnotes filter** under *Enabled filters*.
   Or in config: `filters.filter_footnotes.status: true` with `id: filter_footnotes`,
   `provider: footnotes`.
2. **Add the toolbar button.** In the same form drag **Footnotes** into the *Active toolbar*,
   or in `editor.editor.<format>` add `footnotes` to `settings.toolbar.items`.
3. **Allow the tags.** The CKEditor plugin declares the elements it needs
   (`<footnotes data-text data-value>`, `<footnotes-placeholder>`, `<ul>/<li>/<span>/<a>` with
   classes). With "Limit allowed HTML tags" on, these are added automatically when the button
   is enabled.
4. Save. Editors now see a **Footnotes** button that opens the insert dialog.

## Filter settings (set when enabling the filter)

`filter_footnotes.settings` (see [../plugins/filter.md](../plugins/filter.md) for detail):

```yaml
footnotes_collapse: false               # merge identical notes into one number
footnotes_css: true                     # load the bundled footnotes.css
footnotes_dialog: false                 # show notes in a popup instead of the footer
footnotes_dialog_prevent_bubbling: false
footnotes_footer_disable: false         # hide the inline footer (use the block instead)
footnotes_preview_show_text: true       # show reference text in the editor preview
footnotes_preview_character: ''         # override the preview marker character
```

Read a format back: `drush cget filter.format.footnote filters.filter_footnotes`.

## Dependencies / requirements

Requires `ckeditor5`, `editor`, and `media`. The Footnotes button only works on a **CKEditor 5**
format. There is no global settings page — everything is per-format config, plus the optional
Footnotes Group block (see [../plugins/block.md](../plugins/block.md)).
