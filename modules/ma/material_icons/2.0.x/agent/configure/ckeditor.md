# Material Icons in CKEditor 5

The module ships a CKEditor 5 plugin (`material_icons.ckeditor5.yml`, plugin id
`materialIcons.MaterialIcons`) that adds a **Material Icons** toolbar button.

## Add the button to a text format

1. Go to *Configuration » Content authoring » Text formats and editors*
   (`/admin/config/content/formats`).
2. Edit a CKEditor 5 format (e.g. **Full HTML**) and click *Configure*.
3. Drag the **Material Icons** button from *Available buttons* into the *Active toolbar*.
4. Make sure the format's filters allow `<span>` with `class` (the plugin inserts
   `<span class="…">`). The CKEditor5 config declares `htmlSupport` for `<span class>` and the
   elements `<span>` / `<span class>`.
5. Save.

In config this appears in `editor.editor.<format>` under
`settings.toolbar.items: [ …, materialIcons ]` and
`settings.plugins.material_icons_icons`.

## What the button does

Clicking it opens the `material_icons.dialog` modal (route `/material_icons/dialog`,
permission `use material icons`) — the same autocomplete icon picker used by the field
widget — and inserts a `<span>` carrying the chosen icon's family class and name.

## Requirements & notes

- The dialog and its autocomplete require the `use material icons` permission.
- The rendered icons only display if the relevant font family is enabled in
  `material_icons.settings` (see [configure/settings.md](../configure/settings.md)); the
  plugin also injects the enabled families' CSS into the editing view.
- CKEditor 4 is supported by a separate legacy plugin
  (`src/Plugin/CKEditorPlugin/MaterialIcons.php` + `js/plugins/material_icons/plugin.js`) for
  sites still on the `ckeditor` module; CKEditor 5 is the default path on Drupal 10/11.
