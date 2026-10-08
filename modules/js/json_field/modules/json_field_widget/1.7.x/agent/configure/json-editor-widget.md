<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `json_editor` widget

## Install the JS library first

```
libraries/
└── jsoneditor/
    └── dist/
        ├── jsoneditor.min.js
        └── jsoneditor.min.css
```

Download a release ≤ 6.0.0 from <https://github.com/josdejong/jsoneditor>, or add it as a
`drupal-library` Composer package (`josdejong/jsoneditor`). Without it,
`json_field_widget_requirements()` reports **JSON Editor library doesn't exists** at
`REQUIREMENT_ERROR` severity and the textarea stays a textarea (no fatal).

## Settings

| key | type | default | meaning |
|---|---|---|---|
| `mode` | string | `code` | mode the editor opens in |
| `modes` | array (checkboxes) | `{text: text}` | modes offered in the editor's mode switcher; the value of `mode` is always prepended |
| `schema` | string | `''` | a JSON Schema document, as text |
| `schema_validate` | bool | `false` | block the save when the value does not match `schema` |

Available modes: `text` (Plain text), `code` (Code Editor (ACE)), `tree` (Tree),
`form` (Form, read-only structure), `view` (View, read-only).

Config schema: `field.widget.settings.json_editor` (extends
`field.widget.settings.string_textarea`).

Stored on the form-display component:

```yaml
# core.entity_form_display.node.article.default
content:
  field_payload:
    type: json_editor
    settings:
      mode: tree
      modes: { tree: tree, code: code, text: text }
      schema: '{"type":"object","required":["sku"],"properties":{"sku":{"type":"string"}}}'
      schema_validate: true
```

## Set it with Drush

```php
drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_payload", [
    "type" => "json_editor", "weight" => 30, "region" => "content",
    "settings" => [
      "mode" => "code",
      "modes" => ["code" => "code", "text" => "text"],
      "schema" => "",
      "schema_validate" => FALSE,
    ],
  ])->save();
'
```

Read it back:

```bash
drush cget core.entity_form_display.node.article.default content.field_payload
```

## In the UI

*Manage form display* for the bundle → change the JSON field's widget to
**JSON-specific WYSIWYG editor** → cog → pick *Editor mode*, tick *Available modes*, paste a
schema into *JSON schema to validate the field*, tick *Validate against the schema* →
**Update** → **Save**. The settings summary reads
`Mode: <mode>` / `Available modes: …` / `JSON schema: Yes|No` / `JSON schema validation: Yes|No`.

## How it renders

`JsonEditorWidget::formElement()` builds a normal `textarea` with
`#attributes['data-json-editor'] = sha256(serialize(['mode' => …, 'modes' => …, 'schema' => …]))`
and attaches `json_field_widget/json_editor.widget` plus
`drupalSettings.json_field[<hash>] = $editor_config`. `assets/js/json_widget.js` finds each
`[data-json-editor]` textarea and instantiates JSONEditor with that config. The hash means
two fields with identical settings share one drupalSettings entry.

## Schema validation

* Client side: JSON Editor shows schema errors live when `schema` is set.
* Server side: only when **both** `schema` is non-empty and `schema_validate` is TRUE. The
  `#element_validate` callback `JsonEditorWidget::validateJsonData()` runs
  `Swaggest\JsonSchema\Schema::import(json_decode($schema))->in(json_decode($value))` and, on
  any exception, sets the form error **"JSON Schema validation failed."**
  Empty values on a non-required field are skipped.
* The schema textarea on the settings form is itself checked by
  `JsonEditorWidget::validateJsonSchema()` → error **"JSON Schema is not valid."**
  An empty schema is never validated (otherwise the settings form could not be saved).

`Swaggest\JsonSchema` comes from the Composer package **`swaggest/json-schema`**, which the
parent project only *suggests*. Install it (`composer require swaggest/json-schema`) before
turning `schema_validate` on, otherwise the validate callback hits a missing class.
