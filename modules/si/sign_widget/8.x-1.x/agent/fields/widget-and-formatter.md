<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sign widget & formatter (image field)

Both plugins target the **core `image` field type** and reuse core's image machinery. Install:
`drush en sign_widget`. Create (or reuse) an image field on any fieldable entity, then select
**Sign** on *Manage form display* (widget) and/or *Manage display* (formatter). No global config
page — every option is a per-display setting stored on the field-display config entity.

## Widget — `SignWidget`

`src/Plugin/Field/FieldWidget/SignWidget.php`, `#[FieldWidget(id: 'sign_widget', label: 'Sign',
field_types: ['image'])]`, extends core `image` module's `ImageWidget`.

- `formElement()` replaces the file upload with a `#theme => 'sign'` canvas plus a **hidden**
  input (class `signature-storage`, id `<field>-sign`). The per-display settings are emitted both
  as `data-*` attributes on the canvas and in `drupalSettings.sign_pad[<id>]`. `js/sign_widget.js`
  (`Drupal.behaviors.sign_widget`) instantiates `SignaturePad` on each `canvas.signature-pad` and,
  on `afterUpdateStroke`, writes `toDataURL('image/png')` into the hidden field.
- If the field already has a value it re-loads the `File`, shows it as the canvas background
  (`background` src → `fromDataURL`), and exposes a **Remove** button (`show_remove_btn`, forced on
  for users with `administer site configuration`).
- `formMultipleElements()` lays deltas out in a Bootstrap `row` / `col-sm` grid instead of the
  standard multi-widget table.
- `massageFormValues()` turns the submitted data-URL into a stored file: it splits off the base64
  payload, `base64_decode`s it, and `file.repository->writeData()`s it to
  `<default_scheme>://<file_directory>/<ymd>_<rand>.png` (`FileExists::Replace`), then sets
  `target_id`, `width`, `height` from `getimagesize()`. A numeric value (an existing fid) is passed
  through unchanged. The destination `file_directory` comes from the **field's own** image settings,
  token-replaced via `token->replace()` + `PlainTextOutput::renderFromHtml()`.
- Extra services injected via `create()`: `entity.repository`, `file_system`, `file.repository`,
  `token`, `current_user`, `config.factory` (on top of `ImageWidget`'s `element_info`,
  `image.factory`).

## Formatter — `SignFormatter`

`src/Plugin/Field/FieldFormatter/SignFormatter.php`, `#[FieldFormatter(id:
'sign_widget_formatter', label: 'Sign', field_types: ['image'])]`, extends core `ImageFormatter`.

- `viewElements()` first calls `parent::viewElements()` to render already-stored signatures as
  images. Then, if the field's **cardinality is greater than the number of stored items**, it
  appends one or more **live canvases** (`#theme => 'sign'`) plus a hidden `signature-storage`
  input carrying `data-entity_type`, `data-entity_id`, `data-field_name`, `data-bundle`,
  `data-field_type`, `data-file_directory`, `data-delta`. A Save action in `js/sign_widget.js`
  POSTs these to `sign_widget.sendSign` (see [../plugins/ckeditor5.md](../plugins/ckeditor5.md) for
  the route table) to attach the drawing to the field from the rendered display.
- Canvas width/height derive from the field's `default_image`, `max_resolution`/`min_resolution`,
  or the `canvasWidth` setting (fallback 288×180).

## Settings (widget + formatter)

`defaultSettings()` (both plugins), schema `config/schema/sign_widget.schema.yml`
(`field.widget.settings.sign_widget_widget`, `field.formatter.settings.sign_widget_formatter`):

| key | type | widget default | formatter default | meaning |
|-----|------|----------------|-------------------|---------|
| `dotSize` | float | 1 | 1 | radius of a single dot |
| `minWidth` | float | 0.5 | 0.5 | min stroke width |
| `maxWidth` | float | 2.5 | 2.5 | max stroke width |
| `backgroundColor` | string | '' | '' | canvas background; `#fff/#000` are coerced to transparent `rgba(255,255,255,0)` in the widget |
| `penColor` | string | `#000000` | `#000000` | line colour |
| `velocityFilterWeight` | float | 0.7 | 0.7 | velocity smoothing |
| `canvasWidth` | integer | 288 | 288 | canvas width (px) |
| `signTool` | boolean | FALSE | FALSE | show the colour/size toolbox |
| `show_remove_btn` | boolean | FALSE | TRUE | show remove/reset button |
| `local` | boolean | FALSE | FALSE | load signature_pad locally instead of CDN |

`settingsForm()` exposes each as a number/color/checkbox element; `settingsSummary()` echoes the
active ones on the *Manage (form) display* summary. The formatter's form also inherits the core
image-formatter settings (image style, link) from `parent::settingsForm()`.

## Operate

- Uncheck *Alt field required* / *Title field required* on the image field or the empty-canvas
  submit will fail validation.
- Multi-value fields render a canvas per delta (widget) and a spare canvas (formatter) up to
  cardinality.
- Stored files are managed `file` entities under the field's configured file directory; filenames
  are `date('ymd')_rand(1000,9999).png`.
