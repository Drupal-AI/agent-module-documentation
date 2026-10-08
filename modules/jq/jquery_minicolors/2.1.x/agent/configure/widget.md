# Configure the jQuery MiniColors widget

## Attach it to a field

`jquery_minicolors_widget` is a **field widget** for **`string` (Text plain)** fields. Choose it on
the bundle's *Manage form display* (e.g. `/admin/structure/types/manage/article/form-display`) for a
string field and Save. In the `entity_form_display` config the component becomes:

```yaml
content:
  field_color:
    type: jquery_minicolors_widget
    weight: 5
    region: content
    settings:
      size: 25
      placeholder: ''
      control: hue
      format: hex
      # ...see table below
```

Set it programmatically:

```php
\Drupal::entityTypeManager()->getStorage('entity_form_display')
  ->load('node.article.default')
  ->setComponent('field_color', ['type' => 'jquery_minicolors_widget', 'region' => 'content'])
  ->save();
```

The value is stored as a plain string (e.g. `#ff0000`) in the string field — there is no dedicated
field type.

## Widget settings

Stored under `field.widget.settings.jquery_minicolors_widget`; each becomes a `data-*` attribute on
the input (class `mini-colors`) read by `js/jquery-minicolors.js`. Defaults from
`JqueryMinicolorsWidget::defaultSettings()`:

| Setting | Default | Notes |
|---|---|---|
| `control` | `hue` | hue / brightness / saturation / wheel |
| `format` | `hex` | hex / rgb |
| `opacity` | `0` | enable alpha slider |
| `swatches` | `''` | up to 7 colors, pipe-separated (spaces stripped) |
| `position` | `bottom left` | dropdown position |
| `theme` | `default` | default / bootstrap |
| `inline` | `0` | render picker always-open inline |
| `animation_speed` | `50` | ms (0 = none) |
| `animation_easing` | `swing` | easing name |
| `change_delay` | `0` | ms debounce of change event |
| `letter_case` | `lowercase` | uppercase / lowercase hex |
| `show_speed` | `100` | ms |
| `hide_speed` | `100` | ms |
| `keywords` | `''` | accepted keywords (e.g. `transparent, inherit`) |
| `size` | `25` | text input size (core) |
| `placeholder` | `''` | input placeholder (core) |

## External library requirement

The widget attaches the `jquery_minicolors/jquery_minicolors` library, which loads the external
**jQuery MiniColors** library **v2.2.4** from `/libraries/jquery-minicolors/`:
`jquery.minicolors.min.js` and `jquery.minicolors.css` must be present there. If missing,
`hook_requirements()` shows an error on `/admin/reports/status` ("jQuery Minicolors Library — Not
Installed"). The picker just won't initialise without it; the field still stores/edits a plain
string. No admin settings page, no permissions, no Drush.
