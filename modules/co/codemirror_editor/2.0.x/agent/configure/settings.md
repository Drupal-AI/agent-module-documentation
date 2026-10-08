# Global settings

Route `codemirror_editor.settings` → `/admin/config/content/codemirror` (menu: Configuration
→ Content authoring → CodeMirror). Permission required: **`administer codemirror editor`**
(restricted access). Form class `SettingsForm` edits the `codemirror_editor.settings` config
object.

## Config keys (`codemirror_editor.settings`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `cdn` | boolean | `true` | Load the CodeMirror library from a CDN. If `false`, the library must exist under `libraries/codemirror` (see `drush/download.md`). |
| `minified` | boolean | `true` | Use the minified CodeMirror build. |
| `theme` | string | `default` | CodeMirror editor theme applied to all instances. |
| `language_modes` | sequence(string) | `[xml]` | Mode plugin ids preloaded globally (see `plugins/modes.md`). |

## Read / write with drush

```bash
drush cget codemirror_editor.settings
drush cset codemirror_editor.settings cdn 0 -y          # self-host instead of CDN
drush cset codemirror_editor.settings theme material -y
```

Set the preloaded language modes (a sequence) in PHP:
```php
\Drupal::configFactory()->getEditable('codemirror_editor.settings')
  ->set('language_modes', ['css', 'javascript', 'twig'])
  ->save();
```

## Notes

- Saving the form invalidates cache tags so the changed library settings take effect.
- The runtime `hook_requirements` check reports the CodeMirror library as missing **only when
  `cdn` is false** and the files are not found under `libraries/codemirror`.
- Per-instance options (toolbar, buttons, lineWrapping, lineNumbers, foldGutter,
  autoCloseTags, styleActiveLine, mode, rows, placeholder) are set on each consuming plugin's
  own settings, not here — see `api/usage.md`. Their schema types are
  `codemirror_plugin_settings`, `field.widget.settings.codemirror_editor`,
  `field.formatter.settings.codemirror_editor`, `editor.settings.codemirror_editor`, and
  `filter_settings.codemirror_editor`.
