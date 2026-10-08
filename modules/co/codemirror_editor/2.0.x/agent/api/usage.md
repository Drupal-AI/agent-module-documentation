# Using CodeMirror (element & provided plugins)

All the plugins below share the id **`codemirror_editor`** and one JS library/toolbar.

## Render element `#type => 'codemirror'`

`Element/CodeMirror.php` (`@FormElement("codemirror")`, extends core `textarea`). Use in any
form:
```php
$form['snippet'] = [
  '#type' => 'codemirror',
  '#title' => $this->t('Snippet'),
  '#codemirror' => [
    'mode' => 'text/html',
    'lineNumbers' => TRUE,
    'lineWrapping' => FALSE,
    'foldGutter' => FALSE,
    'toolbar' => TRUE,
    'autoCloseTags' => TRUE,
    'buttons' => ['bold', 'italic', 'link'],   // toolbar buttons
  ],
];
```
`drupalSettings.codeMirrorEditor` (see `codemirror_editor.libraries.yml`) lists all supported
per-instance keys and their defaults (theme, mode, lineWrapping, lineNumbers, readOnly,
foldGutter, width, height, toolbar, autoCloseTags, styleActiveLine, buttons).

## Text-format editor plugin (`@Editor` id `codemirror_editor`)

Turns a text format's textarea into CodeMirror. Enable at
`/admin/config/content/formats/manage/<format>` → **Text editor: CodeMirror editor**. Config
stored under the editor entity as `editor.settings.codemirror_editor` (`mode`). Note
`supports_content_filtering = FALSE`, `is_xss_safe = FALSE`.

## Filter plugin (`#[Filter]` id `codemirror_editor`)

`type: FilterInterface::TYPE_TRANSFORM_IRREVERSIBLE`. Enable it on a text format's filters to
render code with CodeMirror. Settings (`filter_settings.codemirror_editor`): `lineWrapping`
(default FALSE), `lineNumbers` (default TRUE), `foldGutter` (default FALSE).

## Field widget (`@FieldWidget` id `codemirror_editor`)

For `string_long` and `text_long` fields. Select it on **Manage form display**. Settings
(`field.widget.settings.codemirror_editor`): `mode`, `rows`, `placeholder` (plus the shared
`codemirror_plugin_settings` toolbar/buttons/line* keys).

```php
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')->load('node.article.default');
$fd->setComponent('field_code', [
  'type' => 'codemirror_editor',
  'settings' => ['mode' => 'text/css', 'rows' => 10, 'placeholder' => 'Enter CSS'],
])->save();
```

## Field formatter (`@FieldFormatter` id `codemirror_editor`)

For `string_long` and `text_long` fields. Select it on **Manage display**. Settings
(`field.formatter.settings.codemirror_editor`): `mode`, `lineWrapping`, `lineNumbers`,
`foldGutter`. Renders stored code read-only with highlighting.

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$vd->setComponent('field_code', [
  'type' => 'codemirror_editor',
  'settings' => ['mode' => 'text/css', 'lineNumbers' => TRUE],
])->save();
```

## Shared trait

`CodeMirrorPluginTrait` / `buildCodeMirrorSettingsForm()` builds the common settings sub-form
(line wrapping, line numbers, fold gutter, etc.) reused across these plugins.
