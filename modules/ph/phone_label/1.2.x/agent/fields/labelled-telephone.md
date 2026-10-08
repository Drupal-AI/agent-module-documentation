<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Labelled telephone number" field type, widget & formatter

## Install & enable

```bash
composer require drupal/phone_label
drush en phone_label -y
```

Only dependency is core **`telephone`** (declared in `phone_label.info.yml`). No sub-modules, no
permissions, no Drush commands, no services, no `.module` file.

## Add the field (it is a new field type)

The field type id is **`phone_label`**, label **"Labelled telephone number"**. It is a *distinct
field type that subclasses core telephone* — not a third-party setting on core's `telephone` field.
So you add a **new field** of this type; you cannot flip an existing `telephone` field to it in
place (converting means adding a new field and migrating values).

UI path: *Structure → (bundle) → Manage fields → Add field →* choose **Labelled telephone number**.

### Field settings (`PhoneLabelItem::fieldSettingsForm()`)

One setting, key **`title`**, shown as radios **"Allow label override"**:

| Value | Constant | Effect |
|---|---|---|
| Disabled | `DRUPAL_DISABLED` (default) | No label input; label field is hidden on the widget. |
| Optional | `DRUPAL_OPTIONAL` | Label input shown, not required. |
| Required | `DRUPAL_REQUIRED` | Label input shown and required (when the number is required). |

`defaultFieldSettings()` = `['title' => DRUPAL_DISABLED]`.

## Storage (`PhoneLabelItem::schema()` / `propertyDefinitions()`)

Extends core `TelephoneItem`. Two columns:

- **`title`** — `varchar(256)`, "The label text." Added by this module.
- **`value`** — `varchar(256)`, the telephone number (as in core telephone).

`propertyDefinitions()` adds a `title` string property (`t('Phone label')`) on top of
`TelephoneItem::propertyDefinitions()`, so `$item->title` and `$item->value` are both available.
Set values via the entity API exactly like core telephone plus a title, e.g.
`$entity->field_phone->value = '+0123456789'; $entity->field_phone->title = 'Reception';`
(see `tests/src/Kernel/PhoneLabelItemTest.php`).

Plugin defaults: `default_widget = phone_label_default`, `default_formatter = basic_string`
(core's plain string formatter — **not** this module's link formatter, which is opt-in).

## Widget: `phone_label_default` ("Labelled phone number")

`PhoneLabelDefaultWidget extends TelephoneDefaultWidget`, `field_types = { phone_label }`.

- **`defaultSettings()`** adds `placeholder_title => ''` on top of core's widget settings
  (which include `placeholder` for the number).
- **`settingsForm()`** adds a **"Placeholder for label text"** textfield; it is hidden (`#states`
  invisible) when the field's `title` setting is Disabled.
- **`formElement()`** builds core's telephone element, then adds:
  - `title` — a **Label** textfield, `#maxlength 255`, `#default_value = $items[$delta]->title`,
    `#placeholder` from `placeholder_title`, `#weight 2`;
    `#access` = (field `title` setting !== Disabled),
    `#required` = (field `title` setting === Required **and** the number element is required).
  - On **multi-value** fields it also sets a "Telephone number" title on the `value` element and,
    when the label shows, wraps the delta element in a `fieldset`.

Widget config schema (`field.widget.settings.phone_label_default`): `placeholder`, `placeholder_title`.

## Formatter: `phone_label` ("Telephone link with label")

`PhoneLabelFormatter extends FormatterBase`, `field_types = { phone_label }`, **no settings**
(schema `field.formatter.settings.phone_label` is an empty mapping). Choose it on
*Manage display* to render the `tel:` link (otherwise the field uses core `basic_string`).

`viewElements()` per item:

1. `$phone_number = preg_replace('/\s+/', '', (string) $item->value)` — strips all whitespace.
2. If the stripped number is `<= 5` chars, inserts a `-` after the first character
   (`substr_replace($phone_number, '-', 1, 0)`).
3. Builds `#type => 'link'` with:
   - `#title = $item->title ?: $item->value` — the label, or the number when no label;
   - `#url = Url::fromUri('tel:' . rawurlencode($phone_number))`, `#options = ['external' => TRUE]`.
4. Merges any `$item->_attributes` into the link `#options['attributes']`, then unsets them.

Link text is rendered through core's link generator (escaped), and the number is `rawurlencode`d
into the `tel:` URI — the same pattern as core's `TelephoneLinkFormatter`.

## Config schema (`config/schema/phone_label.schema.yml`)

```yaml
field.field_settings.phone_label:      # title (label override), value
field.formatter.settings.phone_label:  # empty mapping (no formatter settings)
field.widget.settings.phone_label_default:  # placeholder, placeholder_title
```

## Config / Drush example (view display formatter)

```bash
drush cset core.entity_view_display.node.contact.default \
  content.field_phone.type phone_label -y
drush cr
```

## Gotchas

- New field type → **no in-place upgrade** from core `telephone`; plan a field add + value
  migration.
- Default formatter is core `basic_string`; explicitly select **"Telephone link with label"** to
  get the `tel:` link and the label.
- The field-settings schema maps `title` as `string` (the stored value is actually the integer
  `DRUPAL_DISABLED/OPTIONAL/REQUIRED` constant); it saves and works regardless.
