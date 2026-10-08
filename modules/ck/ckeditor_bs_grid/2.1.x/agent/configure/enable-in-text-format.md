<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enabling Bootstrap Grid on a text format

## Via the UI

1. *Configuration › Content authoring › Text formats and editors*
   (`/admin/config/content/formats`), edit a format that uses **CKEditor 5**.
2. Drag the **Bootstrap Grid** button from *Available buttons* into the *Active toolbar*.
3. A **Bootstrap Grid** vertical tab appears under the toolbar with:
   - **Use BS CDN** (`use_cdn`) — loads Bootstrap CSS *inside CKEditor only*.
   - **CDN URL** (`cdn_url`).
   - **Allowed Columns** (`available_columns`) — checkboxes 1–12, required.
   - **Allowed Breakpoints** (`available_breakpoints`) — checkboxes built from
     `ckeditor_bs_grid.settings:breakpoints`, required.
4. Make sure the format does not strip the markup: the plugin declares `<div>` and
   `<div class data-*>`. On a *Limit allowed HTML tags* format those are added automatically by
   the plugin's `elements`; on a Full-HTML-style format nothing more is needed.
5. Save.

## The resulting config

```yaml
# editor.editor.<format>
editor: ckeditor5
settings:
  toolbar:
    items:
      - bold
      - italic
      - bootstrapGrid          # <- the toolbar item id
  plugins:
    ckeditor_bs_grid_grid:
      use_cdn: false
      cdn_url: 'https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css'
      available_columns:
        - '1'
        - '2'
        - '3'
      available_breakpoints:
        - xs
        - md
```

Schema: `ckeditor5.plugin.ckeditor_bs_grid_grid` (`use_cdn` bool with `NotNull`, `cdn_url`
string, `available_columns` sequence, `available_breakpoints` sequence).
Defaults from `BsGrid::defaultConfiguration()`: `use_cdn: TRUE`, the jsDelivr Bootstrap 5.2.3
URL, all 12 columns, all six breakpoints.

## Scripted (drush php:eval)

```php
use Drupal\filter\Entity\FilterFormat;
use Drupal\editor\Entity\Editor;

FilterFormat::create(['format' => 'grid_format', 'name' => 'Grid format', 'weight' => 10, 'filters' => []])->save();
Editor::create([
  'format' => 'grid_format',
  'editor' => 'ckeditor5',
  'settings' => [
    'toolbar' => ['items' => ['bold', 'italic', 'bootstrapGrid']],
    'plugins' => [
      'ckeditor_bs_grid_grid' => [
        'use_cdn' => FALSE,
        'cdn_url' => 'https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css',
        'available_columns' => ['1', '2', '3'],
        'available_breakpoints' => ['xs', 'md'],
      ],
    ],
  ],
])->save();
```

Adding the button to an **existing** format:

```php
$editor = Editor::load('basic_html');
$settings = $editor->getSettings();
$settings['toolbar']['items'][] = 'bootstrapGrid';
$settings['plugins']['ckeditor_bs_grid_grid'] = [
  'use_cdn' => TRUE,
  'cdn_url' => 'https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css',
  'available_columns' => array_map('strval', range(1, 12)),
  'available_breakpoints' => ['xs', 'sm', 'md', 'lg', 'xl', 'xxl'],
];
$editor->setSettings($settings);
$editor->save();
```

Read it back:

```bash
drush cget editor.editor.basic_html settings.plugins.ckeditor_bs_grid_grid
drush ev 'print json_encode(\Drupal\editor\Entity\Editor::load("basic_html")->getSettings()["toolbar"]["items"]) . PHP_EOL;'
```

## Runtime config handed to the JS

`BsGrid::getDynamicPluginConfig()` merges the stored configuration into the static
`bootstrapGrid` config from `ckeditor_bs_grid.ckeditor5.yml` and adds
`dialogURL` = `Url::fromRoute('ckeditor_bs_grid.dialog', ['editor' => <format id>])`, so the
JavaScript knows which dialog to open. Static config also sets the modal size (75% × 75%,
`dialogClass: grid-widget-modal`, title "Grid Settings") and points `openDialog` at
`Drupal.ckeditor5.openDialog`.

## Libraries

| Library | When | Contents |
|---|---|---|
| `ckeditor_bs_grid/cke5.bsgrid` | in the editor | `js/build/bootstrapGrid.js` + `ckeditor5/ckeditor5` + `ckeditor_bs_grid/dialog` |
| `ckeditor_bs_grid/dialog` | in the dialog | `css/dialog.css`, `css/grid.css` |
| `ckeditor_bs_grid/cke5.admin` | on the text-format form | `css/cke5-admin.css` |
