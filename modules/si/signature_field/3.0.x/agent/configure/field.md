# Signature Field — field type, widget, formatter

No global settings page (`configure` null) and no permissions. You add a **Signature** field on an
entity's *Manage fields* tab; everything is configured on the field's widget in *Manage form display*.

## The three plugins (`src/Plugin/Field/…`)

| Plugin | id | Notes |
|---|---|---|
| Field type | `field_signature` | `default_widget = field_signature_field_widget`, `default_formatter = field_signature_field_formatter`. Storage: one `value` column, `type: text`, `size: big`, nullable. Single `string` property `value`. |
| Widget | `field_signature_field_widget` (label "Signature Data") | Renders canvas + textarea; see settings below. |
| Formatter | `field_signature_field_formatter` (label "Signature formatter") | Outputs `['#type' => 'html_tag', '#tag' => 'img', '#attributes' => ['src' => $item->value]]` per item. |

## Widget settings (`defaultSettings()` / schema `field.widget.settings.field_signature_field_widget`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `show_data_box` | bool | `TRUE` | Show the raw data-URL textarea. When off, the textarea is still present but gets the `visually-hidden` class (value still submitted). |
| `show_thumb` | bool | `FALSE` | Show a live `<img id="signature-thumb">` thumbnail updated on each stroke. |
| `canvas_width` | int | `400` | Canvas width (px). |
| `canvas_height` | int | `200` | Canvas height (px). |
| `min_line_width` | int | `1` | Min pen stroke width (passed to signature_pad `minWidth`). |
| `max_line_width` | int | `2` | Max pen stroke width (signature_pad `maxWidth`). |
| `pen_color` | string | `''` | Hex color; input is `#type color` if core `color` module enabled, else `textfield`. Converted to `rgb(r, g, b)` via `_signature_field_color_unpack()`. |
| `background_color` | string | `''` | Hex canvas background color, same handling as `pen_color`. |

## How the value is produced (JS data flow)

1. Widget attaches library `signature_field/signature_pad` (CDN `signature_pad@4.0.0` + `js/signature.js` + `css/signature.css`, depends on `core/jquery`, `core/once`).
2. `templates/signature.html.twig` renders `<canvas class="signature-canvas" data-min-line-width data-max-line-width data-pen-color data-bg-color>` plus a `.clear-signature-button`.
3. `js/signature.js` instantiates `new SignaturePad(canvas)`, applies the data-* options, and on the `endStroke` event writes `signaturePad.toDataURL()` (a `data:image/png;base64,…` string) into the `.signature-data` textarea (and the thumb `<img>`).
4. On submit, that textarea string is saved verbatim to the `field_signature` `value` column.
5. If a stored value exists, the template renders `<img class="signature-image" src="{value}">`; the JS hides the canvas and offers a "change" flow to re-draw.

## Add the field with Drush (example)

```php
// drush php:eval — add a signature field to node.article
\Drupal\field\Entity\FieldStorageConfig::create([
  'field_name' => 'field_customer_signature',
  'entity_type' => 'node',
  'type' => 'field_signature',
])->save();
\Drupal\field\Entity\FieldConfig::create([
  'field_name' => 'field_customer_signature',
  'entity_type' => 'node',
  'bundle' => 'article',
  'label' => 'Customer signature',
])->save();
\Drupal::entityTypeManager()->getStorage('entity_form_display')->load('node.article.default')
  ->setComponent('field_customer_signature', [
    'type' => 'field_signature_field_widget',
    'settings' => ['canvas_width' => 500, 'pen_color' => '#0000ff', 'show_thumb' => TRUE],
  ])->save();
```

## Notes / hardening

- The stored value is a plain string the user's browser fills in via the textarea; a user with edit
  access to the field can put any string there. The formatter puts it into an **img `src`** rendered
  through core's `Attribute` object (quotes/entities escaped), so it cannot break out into markup — but
  it is not validated to be a `data:` URL, so a hostile editor could point the `src` at an arbitrary URL
  (an image beacon). This is content-editor-gated and low impact; validate/normalize the value on save
  if you accept signatures from low-trust roles.
- signature_pad loads from a public **CDN** by default (`cdn.jsdelivr.net`). Override the
  `signature_field/signature_pad` library (e.g. via `hook_library_info_alter`) to self-host if you must
  avoid third-party assets.
- The separate `signature` `FormElement` (`src/Plugin/Field/Element/Signature.php`, note the odd
  `Plugin\Field\Element` namespace) is minimal: `valueCallback()` returns the element unchanged and does
  not capture input, so prefer the field widget.
