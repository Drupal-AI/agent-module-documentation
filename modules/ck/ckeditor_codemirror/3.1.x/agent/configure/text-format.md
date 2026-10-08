<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enable CodeMirror on a text format

There is **no module settings page**. Everything is per text format, stored in the
`editor.editor.<format>` config entity.

## Prerequisite

The format's toolbar must include core's Source editing button, otherwise the plugin's
`conditions` are unmet and the "CodeMirror source editing" vertical tab is not rendered:

```yaml
settings:
  toolbar:
    items: [ ..., sourceEditing ]
  plugins:
    ckeditor5_sourceEditing:
      allowed_tags: {  }
```

## Config keys

```yaml
# editor.editor.<format>
settings:
  plugins:
    ckeditor_codemirror_source_editing:
      enable: true            # master on/off (default FALSE)
      mode: htmlmixed         # see modes below (default 'htmlmixed')
      options:                # all default TRUE
        autoCloseBrackets: true
        autoCloseTags: true
        folding: true         # adds the fold gutter
        lineNumbers: true     # adds the line-number gutter
        lineWrapping: true
        matchBrackets: true
        matchTags: true
        searchBottom: true    # search bar at the bottom
        styleActiveLine: true
```

Schema: `ckeditor5.plugin.ckeditor_codemirror_source_editing` in
`config/schema/ckeditor_codemirror.schema.yml`.

### `mode` values (the select options, verbatim)

| Value | Label |
|---|---|
| `htmlmixed` | HTML (including css, xml and javascript) |
| `text/html` | HTML only |
| `application/x-httpd-php` | PHP (including HTML) |
| `text/javascript` | Javascript only |
| `css` | CSS |
| `text/x-scss` | SCSS |

## Via the UI

1. *Configuration → Content authoring → Text formats and editors*
   (`/admin/config/content/formats`), **Configure** a CKEditor 5 format.
2. Make sure the **Source** button is in the active toolbar.
3. Open the **CodeMirror source editing** vertical tab under *CKEditor 5 plugin settings*.
4. Tick **Enable CodeMirror source view syntax highlighting**, pick a **Mode**, adjust the
   *Additional settings* checkboxes.
5. **Save configuration**.

## Via drush (scriptable)

Read the current state:

```bash
drush cget editor.editor.full_html settings.plugins.ckeditor_codemirror_source_editing
```

Enable it on an existing format:

```bash
drush php:eval '
  $e = \Drupal\editor\Entity\Editor::load("full_html");
  $s = $e->getSettings();
  if (!in_array("sourceEditing", $s["toolbar"]["items"], TRUE)) {
    $s["toolbar"]["items"][] = "sourceEditing";
    $s["plugins"]["ckeditor5_sourceEditing"]["allowed_tags"] = [];
  }
  $s["plugins"]["ckeditor_codemirror_source_editing"] = [
    "enable" => TRUE,
    "mode"   => "text/x-scss",
    "options" => [
      "autoCloseBrackets" => TRUE, "autoCloseTags" => TRUE, "folding" => TRUE,
      "lineNumbers" => TRUE, "lineWrapping" => TRUE, "matchBrackets" => TRUE,
      "matchTags" => TRUE, "searchBottom" => TRUE, "styleActiveLine" => TRUE,
    ],
  ];
  $e->setSettings($s)->save();
'
```

`drush cset editor.editor.<format> settings.plugins.ckeditor_codemirror_source_editing.enable 1 -y`
works too for single scalar keys.

## Gotchas

- All nine `options` keys must be present — the schema types them as booleans and the
  plugin's `getDynamicPluginConfig()` reads `lineNumbers`, `folding` and `searchBottom`
  unconditionally.
- Removing `sourceEditing` from the toolbar disables the plugin even though the settings
  stay in config.
- `enable: false` still keeps the settings in config; it just does not attach the JS.
