# Font Icon Picker field (type / widget / formatter) + render element

Plugin id `font_iconpicker` across type, widget and formatter. The field type's
`default_widget` and `default_formatter` are both `font_iconpicker`.

## Field type — `...\Plugin\Field\FieldType\FontIconpicker`
Extends `FieldItemBase`.
- One property `value` (string, required).
- Storage schema: single `value` column, `varchar(50)`.
- `isEmpty()` is TRUE when the value is `NULL` or `''`.
- Holds a single icon CSS class string, e.g. `icon-star`.

## Widget — `...\Plugin\Field\FieldWidget\FontIconpicker`
Extends `WidgetBase`.
- `formElement()` renders the item as `#type => 'font_iconpicker'` (the render element
  below), passing `#default_value` from the stored value and `#has_search` from settings.
- Setting `has_search` (bool, default `FALSE`) — checkbox in `settingsForm()`, echoed in
  `settingsSummary()`. Toggles the picker's search box.

## Formatter — `...\Plugin\Field\FieldFormatter\FontIconpicker`
Extends `FormatterBase`.
- `viewElements()` renders each item as
  `['#theme' => 'font_icon', '#icon' => Html::escape($item->value)]` and attaches the
  dynamic font library `font_iconpicker/font-custom` so the glyph font loads.

### Output — theme hook `font_icon`
- Defined by `FontIconpickerHooks::theme()` with a single variable `icon`; template
  `templates/font-icon.html.twig` outputs an `<i>` element carrying the icon class(es) and
  `aria-hidden="true"`.
- `template_preprocess_font_icon()` (in `font_iconpicker.module`) builds a
  `\Drupal\Core\Template\Attribute` object, adds the configured `additional_class` (if any)
  and then the icon class via `Attribute::addClass()`, and sets the render array's cache
  tags from the `font_iconpicker.settings` config. Class values are emitted through the
  `Attribute` object.
- Reusable directly: `['#theme' => 'font_icon', '#icon' => 'icon-star']`.

## Render element — `#type => 'font_iconpicker'`
`Drupal\font_iconpicker\Element\FontIconpicker` (`#[FormElement('font_iconpicker')]`,
extends core `Select`). Usable in any form, independent of the field:

```php
$form['icon'] = [
  '#type' => 'font_iconpicker',
  '#title' => $this->t('Icon'),
  '#default_value' => 'icon-star',
  '#has_search' => TRUE, // optional, default FALSE
];
```

Behavior:
- `#process` → `processFontIconpicker()`: fills `#options` from
  `font_iconpicker.icon_helper::getIconsAvailable()` via `array_combine()` (value === label);
  on `\LogicException` it logs to channel `font_iconpicker` and leaves `#options` empty; sets
  `#empty_value => ''`; when the element is required and has no default, selects the first
  available icon.
- `#pre_render` → `preRenderFontIconpicker()`: adds class `font-iconpicker-element`; sets
  attributes `data-fonticonpicker-empty-icon` (empty unless required) and
  `data-fonticonpicker-has-search`; attaches library `font_iconpicker/form-element`; passes
  `additional_class`, `data_attribute_prefix` (`data-fonticonpicker-`) and `theme` into
  `drupalSettings.font_iconpicker`.
- As a core `Select` subclass, the submitted value is validated against the built `#options`
  (the parsed icon list).
- JS `js/form-element.js` (Drupal behavior `fontIconpicker`) runs `.fontIconPicker()` on
  every `select.font-iconpicker-element` (once), wiring `theme`, `hasSearch`, `emptyIcon`
  and an `iconGenerator` that previews each option as `<span class="icon [additional]">`.
