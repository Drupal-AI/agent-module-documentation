<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Add the Fullscreen button to a text format's CKEditor 5 toolbar

The module has **no configure route** (`configure: null`) and no settings form. You enable it
per text format by adding the `Fullscreen` toolbar item to that format's CKEditor 5 toolbar.

## The exact toolbar item id

`ckeditor5_fullscreen.ckeditor5.yml` declares:

```yaml
ckeditor5_fullscreen_fullscreen:
  ckeditor5:
    plugins:
      - fullscreen.Fullscreen
  drupal:
    label: Fullscreen
    library: ckeditor5_fullscreen/fullscreen
    admin_library: ckeditor5_fullscreen/fullscreen.admin
    toolbar_items:
      Fullscreen:
        label: Fullscreen
    elements: false
```

The key under `toolbar_items` — **`Fullscreen`** (capital F) — is the literal string Drupal
stores in a text format's toolbar items array. It is confirmed by the admin CSS selector
`.ckeditor5-toolbar-button-Fullscreen` in `css/fullscreen.admin.css`.

## Where the setting is stored

Config entity: `editor.editor.<format>`
Path within it:

```yaml
editor: ckeditor5
format: <format>
settings:
  toolbar:
    items:
      - bold
      - italic
      - Fullscreen
  plugins: {  }
```

`Fullscreen` sits in the same flat `settings.toolbar.items` array as every other CKEditor 5
button (`bold`, `italic`, `sourceEditing`, etc.) — order in the array is the order shown in
the toolbar.

## Via the UI

1. Go to **Administration » Configuration » Content authoring » Text formats and editors**
   (`/admin/config/content/formats`) and click **Configure** on the target format
   (e.g. `/admin/config/content/formats/manage/full_html`).
2. In the CKEditor 5 toolbar builder, drag **Fullscreen** from the "Available buttons" tray
   into the **"Active toolbar"** tray, in whatever position you want the button to appear.
3. Click **Save configuration**.

## Via drush php:eval (scriptable)

```php
$editor = \Drupal::entityTypeManager()->getStorage('editor')->load('<format>');
$settings = $editor->getSettings();
$settings['toolbar']['items'][] = 'Fullscreen';
$editor->setSettings($settings)->save();
```

To remove it, filter `'Fullscreen'` out of `$settings['toolbar']['items']` and save again.

## Read it back

```bash
drush cget editor.editor.<format> settings.toolbar.items
# look for "Fullscreen" in the returned list
```

Or in PHP: `in_array('Fullscreen', $editor->getSettings()['toolbar']['items'], TRUE)`.

## Notes

- No config schema of its own (`provides_config_schema: false`) — the toolbar item is just a
  string in core's own `editor.editor.*` schema, so there's nothing extra to validate.
- The button only does anything when the format's editor is `ckeditor5` — adding `Fullscreen`
  to a format using a different editor (or no editor) has no effect.
- Clicking the button toggles a `data-fullscreen` attribute on the editor's wrapper and on
  `<body>`; this is purely client-side behavior driven by the `ckeditor5_fullscreen/fullscreen`
  library — nothing else is persisted when a user toggles fullscreen mode while editing.
