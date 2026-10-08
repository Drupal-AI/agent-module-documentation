<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The telephone field type, widget and `tel:` link formatter

## Install & enable

```bash
composer require drupal/telephone
drush en telephone -y
```

Only dependency is core **`field`**. No sub-modules, no permissions, no Drush commands, no
configuration route (`configure: null`). Contrib 1.0.x is a copy of core's Telephone module for
Drupal 11.3+/12; ids match core exactly, so moving an existing site to it needs no config changes.

## Field type — `TelephoneItem`

`src/Plugin/Field/FieldType/TelephoneItem.php`, `#[FieldType(id: "telephone")]`, label *"Telephone
number"*, `default_widget: "telephone_default"`, `default_formatter: "basic_string"` (core's plain
string formatter).

- **Storage** (`schema()`): one column `value`, `varchar` of length `MAX_LENGTH = 256`.
- **Property** (`propertyDefinitions()`): a single `string` `value`, `setRequired(TRUE)`.
- **Empty** (`isEmpty()`): true when `value` is `NULL` or `''`.
- **Validation** (`getConstraints()`): adds a `ComplexData` → `Length` constraint with `max = 256`
  and a translated `maxMessage`. **That is the only constraint** — there is no phone-number pattern
  check, so any string up to 256 chars validates. Combine with a pattern/regex field-validation
  module if you need format enforcement.
- **Sample** (`generateSampleValue()`): a random 9-digit integer (`rand(10^8, 10^9 - 1)`), used by
  Devel-generate and tests.

## Widget — `telephone_default`

`src/Plugin/Field/FieldWidget/TelephoneDefaultWidget.php`, `#[FieldWidget(id: 'telephone_default')]`,
`field_types: ['telephone']`.

- `formElement()` builds `#type => 'tel'` (HTML5 telephone input), `#default_value` from the item,
  `#maxlength => TelephoneItem::MAX_LENGTH` (256), and `#placeholder` from the setting.
- One setting, `placeholder` (default `''`) — `settingsForm()` exposes a textfield; `settingsSummary()`
  shows `Placeholder: @placeholder` or *No placeholder*. Schema: `field.widget.settings.telephone_default`.

## Formatter — `telephone_link`

`src/Plugin/Field/FieldFormatter/TelephoneLinkFormatter.php`,
`#[FieldFormatter(id: 'telephone_link')]`, label *"Telephone link"*, `field_types: ['telephone']`.

- One setting, `title` (default `''`) — schema `field.formatter.settings.telephone_link`. When set it
  becomes the visible link text; otherwise the raw number is shown. `settingsSummary()` prints
  *Link using text: @title* or *Link using provided telephone number.*
- `viewElements()` per item:
  - strips whitespace: `$phone_number = preg_replace('/\s+/', '', $item->value)`.
  - if the stripped number is `<= 5` chars, inserts a `-` after the first digit
    (`substr_replace(..., '-', 1, 0)`). This works around a `parse_url()` bug where a short numeric
    string is read as a port number and would make `Url::fromUri('tel:...')` throw
    `InvalidArgumentException` (see PHP bug 70588; RFC 3966 treats `-` as a droppable visual separator).
  - builds `#type => 'link'`, `#title => $title_setting ?: $item->value`,
    `#url => Url::fromUri('tel:' . rawurlencode($phone_number))`, `#options => ['external' => TRUE]`.
  - merges any field-item `_attributes` into `#options['attributes']`, then unsets them.

The number is percent-encoded into a `tel:` URI and the title is rendered through core's link element
(escaped as plain text). There is no other formatter; to show the number as **plain text** use core's
`string` / `basic_string` formatter, which the module's `hook_field_formatter_info_alter()` enables
for this field type.

### Config example (view display)

```yaml
# core.entity_view_display.node.contact.default
content:
  field_phone:
    type: telephone_link
    label: above
    settings:
      title: 'Call us'
```

```bash
drush cset core.entity_view_display.node.contact.default \
  content.field_phone.type telephone_link -y
drush cr
```

## Hooks, library, schema (from source)

- `src/Hook/TelephoneHooks.php` (OO hooks; `telephone.services.yml` sets
  `telephone.skip_procedural_hook_scan: true`):
  - `#[Hook('help')]` → the `help.page.telephone` About/Uses text.
  - `#[Hook('field_formatter_info_alter')]` → `$info['string']['field_types'][] = 'telephone'` so the
    core string formatter can render the field.
  - `#[Hook('field_type_category_info_alter')]` → attaches library `telephone/drupal.telephone-icon`
    to the fallback (general) field-type category so the icon shows in *Add field*.
- `telephone.libraries.yml`: `drupal.telephone-icon` → `css/telephone.icon.theme.css` (an inline SVG
  `background-image` on `.field-icon-telephone`); depends on `field_ui/drupal.field_ui.manage_fields`.
  The `.pcss.css` alongside is the PostCSS source — do not ship-edit the compiled file.
- `config/schema/telephone.schema.yml`: schemas for the formatter setting (`title`), widget setting
  (`placeholder`), and the field default value (`field.value.telephone` → `value` string).

## Notes

- Length is capped at 256 both in storage and in the widget's `#maxlength`.
- No format/pattern validation — treat stored values as free-form strings when reusing them.
- Whitespace is removed only for the `tel:` link target; the display title still shows the raw stored
  value (unless a `title` setting overrides it).
