# Enable the Bookmark button

## Steps
1. Enable the module (`drush en ckeditor5_bookmark -y`).
2. Go to `/admin/config/content/formats`, edit a CKEditor 5–based text format (e.g. Full HTML).
3. Drag the **Bookmark** icon from *Available buttons* into the *Active toolbar*.
4. Save. Editors using that format now see the bookmark button.

There is no module settings page (`configure` is null) — configuration is entirely per-text-format
via core's CKEditor 5 toolbar UI, stored in that format's `editor.editor.<format>` config.

## The plugin definition (`ckeditor5_bookmark.ckeditor5.yml`)
```yaml
ckeditor5_bookmark_enable:
  ckeditor5:
    plugins:
      - bookmark.Bookmark          # the core-bundled CKEditor 5 plugin
  drupal:
    label: Bookmark
    library: ckeditor5_bookmark/ckeditor5.bookmark
    admin_library: ckeditor5_bookmark/internal.admin.bookmark
    toolbar_items:
      bookmark:
        label: Bookmark
    elements:
      - <a id>                     # allowed element so anchors pass the format filter
```

Notes:
- `<a id>` is added to the format's allowed HTML automatically when the button is enabled, so bookmark
  anchors (`<a id="...">`) are not stripped by the *Limit allowed HTML tags* filter.
- No conditions/requirements are declared, so the button is available on any CKEditor 5 format.
- The JS library resolves to core's compiled bookmark asset; the module ships only the admin CSS.
