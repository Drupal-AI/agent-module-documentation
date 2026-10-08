# Field: webicons_field

Add an icon field to any fieldable entity (node, taxonomy term, paragraph, media, user, …). One field
is bound to **one** icon library, chosen in the field settings; editors pick individual icons per item
through an AJAX modal.

## Plugins

| Kind | id | Class |
|---|---|---|
| Field type | `webicons_field` | `Plugin/Field/FieldType/WebIconsFieldItem` |
| Widget (default) | `webicons_field` | `Plugin/Field/FieldWidget/WebIconsFieldWidget` |
| Formatter (default) | `webicons_field_default` | `Plugin/Field/FieldFormatter/WebIconsFieldDefaultFormatter` |

The field type is annotated `category = "Webicons"`, so it appears under the **Web Icons** group in the
"Add field" UI (group defined in `webicons.field_type_categories.yml`).

## Stored properties / schema

| Property | Type | Meaning |
|---|---|---|
| `icon_class` | varchar(255) | CSS class(es) for the icon (e.g. `bx bxs-beer`, `fa-solid fa-heart`, or `material-icons-outlined`). |
| `icon_code` | varchar(255) | Icon code / ligature (Material Icons uses this for the glyph name, e.g. `lock`; empty for font-class libraries). |

`isEmpty()` returns TRUE only when **both** `icon_class` and `icon_code` are NULL. `massageFormValues()`
normalises empty strings to NULL and flattens the widget's `fieldset` wrapper into the two stored columns.

## Field setting

`defaultFieldSettings()` → `icon_library` (default `boxicons`). The field settings form renders a select
of `IconServiceInterface::ICONS`:

| value | label |
|---|---|
| `boxicons` | Box Icons |
| `fortawesome` | Fortawesome Icons |
| `materialicons` | Material Icons |

## Widget behaviour

`WebIconsFieldWidget::formElement()` builds, per delta: a text field `icon_class`, a text field
`icon_code`, a **Select icon** link (`use-ajax`, `data-dialog-type=modal`) pointing at
`Url::fromRoute('webicons.open_selector', ['lid' => $libraryId, 'wid' => $wrapperId])`, and a live
preview built from the library factory's `getIconRenderArray($keyValues, ['webicon-preview'])`. Attaches
`webicons/icon-selector` plus the chosen library asset (`webicons/<libraryId>`). Choosing an icon in the
modal writes `data-class`→`icon_class` and `data-code`→`icon_code` via `assets/js/icon-dialog.js`.
The picker modal is served by [the icon service / controller](../api/services.md).

## Display / formatter

`WebIconsFieldDefaultFormatter::viewElements()` resolves the field's `icon_library` factory and, per item,
returns `$factory->getIconRenderArray($item->getValue())`. That render array is `#theme =>
'webicon_field__value'` with `#tag` = `i` (Boxicons, Font Awesome) or `span` (Material Icons), attaching
the library CSS. See [theme/twig.md](../theme/twig.md) for the template and the equivalent Twig call.

## Add a field without the UI

```php
// Storage (once per bundle set) + instance.
\Drupal\field\Entity\FieldStorageConfig::create([
  'field_name' => 'field_icon',
  'entity_type' => 'node',
  'type' => 'webicons_field',
  'cardinality' => 1, // or -1 for unlimited (multiple icons).
])->save();

\Drupal\field\Entity\FieldConfig::create([
  'field_name' => 'field_icon',
  'entity_type' => 'node',
  'bundle' => 'article',
  'label' => 'Icon',
  'settings' => ['icon_library' => 'fortawesome'],
])->save();
```

Then enable the widget/formatter on the form/view display (`webicons_field` / `webicons_field_default`).
Set a stored value directly with `$node->field_icon = ['icon_class' => 'fa-solid fa-heart', 'icon_code' => '']`.
