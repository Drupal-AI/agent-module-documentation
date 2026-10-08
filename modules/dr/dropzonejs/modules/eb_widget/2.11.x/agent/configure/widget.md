# Entity Browser widgets

Three `@EntityBrowserWidget` plugins in
`src/Plugin/EntityBrowser/Widget/`. They implement Entity Browser's widget plugin type
(they do **not** define a new plugin type). Configure them when editing an Entity Browser
at `/admin/config/content/entity_browser`; settings persist in the browser config entity
(schema `config/schema/dropzonejs_eb_widget.schema.yml`).

## Plugins

| id | Class | Purpose |
|---|---|---|
| `dropzonejs` | `DropzoneJsEbWidget` | Uploads dropped files, saves permanent `file` entities, selects them. |
| `dropzonejs_media_entity` | `MediaEntityDropzoneJsEbWidget` | Extends the above to create Media entities of a chosen media type. |
| `dropzonejs_media_entity_inline_entity_form` | `InlineEntityFormMediaWidget` | Adds an inline entity form to edit media metadata before selecting. |

## Config keys (`entity_browser.browser.widget.dropzonejs`)

| Key | Type | Notes |
|---|---|---|
| `upload_location` | string | Destination URI, token-aware. Default `public://[date:custom:Y]-[date:custom:m]`. |
| `dropzone_description` | text | Drop-zone prompt text. |
| `max_filesize` | string | e.g. `8M` (form shows MB; `M` appended on submit). |
| `extensions` | string | Space-separated allowed extensions. |
| `auto_select` | bool | Submit selection automatically via AJAX after upload. |
| `submit_text` | text | Submit button label (from Entity Browser base). |
| `clientside_resize` | bool | Enable in-browser resize (needs the exif-js library). |
| `resize_width` / `resize_height` | int | Max dimensions (px) when resizing. |
| `resize_quality` | float | 0–1. |
| `resize_method` / `thumbnail_method` | string | `contain` or `crop`. |

Media subtype adds: `media_type` (target media bundle) and `inherit_settings` (reuse an
existing configuration's file settings). The inline-form subtype additionally adds
`form_mode`.

## Behavior notes

- Respects the reference field's `cardinality` validator to cap uploaded files.
- `handleWidgetContext()` lets a field's `upload_validators` override `max_filesize` /
  `extensions` at runtime.
- Uploaded temp files are turned into `file` entities via `dropzonejs.upload_save`, then
  `setPermanent()` + saved on submit.
- Attaches `dropzonejs_eb_widget/common` JS to disable the submit button until uploads
  finish.
