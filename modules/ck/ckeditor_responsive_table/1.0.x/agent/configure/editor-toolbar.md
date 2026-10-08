<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enable the Responsive Table button on a text format

The button is a CKEditor 5 toolbar item with id **`customTable`** (label "Responsive Table"),
defined in `ckeditor_responsive_table.ckeditor5.yml`. Enabling it = adding `customTable` to
the format's CKEditor 5 toolbar, which is stored in the editor config entity
`editor.editor.<format>` under `settings.toolbar.items`.

## Via the UI

1. Go to *Configuration → Content authoring → Text formats and editors*
   (`/admin/config/content/formats`).
2. Click **Configure** on a format that uses **CKEditor 5**.
3. Drag the **Responsive Table** icon from *Available Buttons* into the *Active toolbar*.
4. **Save configuration**.

## Via drush (scriptable)

```php
$editor = \Drupal::entityTypeManager()->getStorage('editor')->load('basic_html');
$settings = $editor->getSettings();
if (!in_array('customTable', $settings['toolbar']['items'], TRUE)) {
  $settings['toolbar']['items'][] = 'customTable';
  $editor->setSettings($settings)->save();
}
```

Read it back:

```bash
drush config:get editor.editor.basic_html settings.toolbar.items
# the list should include: customTable
```

## What the plugin brings

- CKEditor 5 plugins loaded: `table.Table`, `table.TableToolbar`, `table.TableCaption`,
  `table.PlainTableOutput`, `responsiveTable.CustomTable`.
- Table content toolbar: `tableColumn`, `tableRow`, `mergeTableCells`,
  `toggleCustomTableCaption`.
- Allowed elements include `<table>`, `<thead>`, `<tbody>`, `<tfoot>`, `<tr>`, `<th>`/`<td>`
  with `rowspan colspan scope data-label`, and `<caption>` (with `class`).
- Editor library `ckeditor_responsive_table/responsive_table`; admin styling library
  `ckeditor_responsive_table/admin.responsive_table`.
