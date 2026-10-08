# The Button field formatter

`Drupal\button_formatter\Plugin\Field\FieldFormatter\ButtonFormatter` (extends `FormatterBase`).

```
@FieldFormatter(
  id = "button_formatter",
  label = @Translation("Button"),
  field_types = { "file", "link" }
)
```

Select it under **Manage display** for any `link` or `file` field. It renders each field item as a
single anchor styled with the site's button classes.

## Per-display settings (`defaultSettings()` / `settingsForm()`)

| Setting | Type | Default | Effect |
|---|---|---|---|
| `style` | select (required) | `NULL` | Button-style class, chosen from the `styles` vocabulary in `button_formatter.settings` (options are the `class` half of each `class\|Label` line). |
| `is_external` | checkbox | `FALSE` | When checked, an external URL also gets an "external link" class (see below). |
| `show_icon` | checkbox | `TRUE` | Prepend the `icon` markup before the label. |
| `icon` | textfield | `<i class="fa fa-file" aria-hidden="true"></i>` | Raw icon HTML (admin-set); only shown when `show_icon` is on. |
| `download` | checkbox (file fields only) | `FALSE` | Adds the `download` attribute to the anchor. Hidden when `new_tab` is on. |
| `new_tab` | checkbox | `FALSE` | Sets `target="_blank"`. Hidden when `download` is on. |
| `show_custom_label` | checkbox | `FALSE` | Use `custom_label` as the button text instead of the derived label. |
| `custom_label` | textfield | `''` | The custom label text (run through `t()`). |
| `show_description` | checkbox (file fields only) | `FALSE` | Use the file item's `description` as the label. |

`settingsSummary()` prints Style, Show Icon?, Download, Open in New Tab, Show Description?, and
Is external. Note the `download`/`new_tab` and `show_custom_label`/`show_description` pairs are
mutually exclusive via `#states` in the form.

Config schema for these lives in `config/schema/button_formatter.schema.yml` as
`field.formatter.settings.button_formatter`. Caveats worth knowing: the schema also lists `size`
and `radius` keys, but the formatter's `defaultSettings()`/`settingsForm()` do **not** expose size
or radius selects, so those are inert for the rendered button at this version; conversely
`is_external` is a real setting but is missing from the schema. The schema file also contains two
typos (`type: boolran` for `show_custom_label`, and a `radius::` key with a doubled colon).

## How a button is rendered (`viewElements()`)

For each field item the formatter builds:

```php
$elements[$delta] = [
  '#theme' => 'button_link',
  '#button' => Link::fromTextAndUrl($this->getLabel($item), $this->getUrl($item)),
  '#entity' => $items->getEntity(),
  '#field_name' => $items->getFieldDefinition()->getName(),
];
```

The `button_link` theme hook (see [../theme/button-link.md](../theme/button-link.md)) just prints
the `Link` object, which core's link generator renders as `<a href="…" class="…">…</a>`.

### The URL (`getUrl()`)
- **file field:** load the referenced file (`target_id`), `File::createFileUrl(FALSE)`, then
  `Url::fromUri(...)`.
- **link field:** `Url::fromUri($item->getValue()['uri'])` (the stored link URI).
- Anchor attributes are then set via `Url::setOption('attributes', …)`: `class` from
  `getClass()`, `download` from the `download` setting, `target` = `_blank` when `new_tab` is on.

### The classes (`getClass()`)
Returns an array: `[ config('global_class'), $this->getSetting('style'), $external_class ]`.
The `$external_class` is only non-empty when the URL is external **and** the `is_external` setting
is on; it uses the `external_link` config value if set, otherwise the literal `external-link`.

### The label (`getLabel()`)
Precedence: if `show_custom_label` → `t($settings['custom_label'])`. Otherwise, for a **file**
field: the `description` (when `show_description`), else the media entity's `label()` if the host
entity is a media, else the file's `label()` (filename). For a **link** field: the item's `title`.
When `show_icon` is on, the label becomes `Markup::create(icon . Html::escape($label))`, i.e. the
derived text is HTML-escaped and the admin icon markup is prepended.
