# Enable Find and replace on a text format

There is no module settings page (`configure` is null). The feature is turned on per text format by
adding its toolbar button.

## Steps (UI)

1. Go to *Configuration → Content authoring → Text formats and editors*
   (`/admin/config/content/formats`).
2. **Configure** the format whose editor is CKEditor 5 (e.g. Full HTML).
3. In the CKEditor 5 toolbar builder, drag **Find and replace** from *Available buttons* into an active
   toolbar row.
4. Save. (Run `ddev drush cr` if the button does not appear.)

## Where it is stored

The toolbar item id is `findandreplace`. It is persisted in the editor config entity
`editor.editor.<format>` under `settings.toolbar.items` — the same place all CKEditor 5 buttons live.
There are no other config keys, and the module has no config schema of its own.

## Plugin / library wiring (reference)

`ckeditor5_findandreplace.ckeditor5.yml`:

```yaml
ckeditor5_findandreplace_findandreplace:
  ckeditor5:
    plugins:
      - findAndReplace.FindAndReplace   # upstream CKEditor 5 plugin
  drupal:
    label: Find and replace
    library: ckeditor5_findandreplace/findandreplace
    admin_library: ckeditor5_findandreplace/admin.findandreplace
    toolbar_items:
      findandreplace:
        label: Find and replace
    elements: false                     # adds NO elements/attributes to content
```

Libraries (`ckeditor5_findandreplace.libraries.yml`):
- `findandreplace` — compiled plugin `js/build/find-and-replace.js` (minified), depends on
  `core/ckeditor5`.
- `theme` — `css/findandreplace.css` (in-editor match highlight styles).
- `admin.findandreplace` — `css/findandreplace.admin.css` (toolbar button icon).

No permission gates the button beyond the standard *use text format* access on the format itself; users
who can use the format get find/replace in the editor.
