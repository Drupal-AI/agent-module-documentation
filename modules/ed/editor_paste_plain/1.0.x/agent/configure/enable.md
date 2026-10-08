# Enable "Paste as plain text" on a text format

There is no global settings page. The plugin is turned on per text format that uses the CKEditor 5 editor.

## Via the UI

1. Go to *Configuration → Content authoring → Text formats and editors*
   (`/admin/config/content/formats`) and edit a format whose editor is **CKEditor 5**.
2. Scroll to **CKEditor 5 plugin settings** and open the **Paste as plain text** tab.
3. Tick **Force pasting as plain text**. Save.

The plugin has no toolbar button — it has no `elements` and only a `requiresConfiguration` condition, so
enabling it is purely this checkbox.

## Where the setting lives

Stored on the `editor` config entity for the format, under `settings.plugins`:

```yaml
# editor.editor.<format_id>.yml
settings:
  plugins:
    editor_paste_plain_text:
      force_paste_plain_text: true
```

Schema: `ckeditor5.plugin.editor_paste_plain_text` → `force_paste_plain_text` (boolean, `NotNull`).
Default configuration (`ForcePastePlainText::defaultConfiguration()`) is `force_paste_plain_text => FALSE`.

## Enable with Drush (example)

```php
// drush php:eval — turn it on for the "basic_html" format.
$editor = \Drupal::entityTypeManager()->getStorage('editor')->load('basic_html');
$settings = $editor->getSettings();
$settings['plugins']['editor_paste_plain_text']['force_paste_plain_text'] = TRUE;
$editor->setSettings($settings)->save();
```

## What it does at runtime

When enabled, `js/build/forcePastePlainText.js` attaches to the CKEditor instance and listens for the
editing view's `clipboardInput` event. On each paste it replaces the incoming content with
`plainTextToHtml(dataTransfer.getData('text/plain'))` — i.e. it takes only the `text/plain` flavour of the
clipboard and re-inserts it, discarding the `text/html` payload and all its formatting. Paste handling is
skipped while the editor is read-only. This is equivalent to the browser's Ctrl+Shift+V "paste without
formatting", applied to every paste.
