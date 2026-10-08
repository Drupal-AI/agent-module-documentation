<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Custom Twig markup" formatter

## Install & enable

```bash
composer require drupal/custom_twig_formatter
drush en custom_twig_formatter -y
```

Only dependency is core **`field`**. No sub-modules, no permissions of its own, no Drush commands,
no routes, no services.

## Enable it on a field

The formatter (plugin id **`custom_twig_markup`**, label *"Custom Twig markup"*) applies to a broad
set of core field types, declared in the `@FieldFormatter` annotation on
`CustomTwigFormatter.php`:

```
boolean, changed, created, comment, daterange, datetime, decimal, entity_reference, email,
file, file_uri, image, integer, language, link, list_integer, list_float, list_string, float,
string, string_long, text, text_long, text_with_summary, telephone, timestamp, uri
```

UI path: *Structure → (bundle) → Manage display* → set the field's format to **Custom Twig markup**
→ click the gear to open the settings.

Setting a formatter is a change to the entity's **view-display config**, which requires the entity
type's *administer … display* permission (e.g. `administer node display`).

Drush / config equivalent (view display):

```bash
drush cset core.entity_view_display.node.article.default \
  content.field_example.type custom_twig_markup -y
drush cr
```

## Formatter settings

`defaultSettings()` returns a single key:

| Setting key | Default | Meaning |
|---|---|---|
| `custom_twig_markup` | `''` | The Twig template string that is compiled and rendered for the field. |

`settingsForm()` renders that key as a **Twig code** `textarea`. It also builds two non-editable
`details` blocks — *"Replacement patterns for this field"* and (when the field is on a real bundle)
*"Replacement patterns for other fields"* — that list, for documentation only, each field's variable
name, its PHP item-list class, and its field type, using `entity_field.manager` to enumerate the
bundle's field definitions.

Config schema (`config/schema/custom_twig_formatter.schema.yml`) defines
`field.formatter.settings.custom_twig_markup` as a mapping with one `string` member,
`custom_twig_markup`.

### Example view-display config

```yaml
# core.entity_view_display.node.article.default
content:
  field_example:
    type: custom_twig_markup
    label: hidden
    settings:
      custom_twig_markup: |
        <span class="name">{{ field_first_name.value }} {{ field_last_name.value }}</span>
```

## The render context (from `viewElements()`)

At view time the formatter constructs `$context` from the entity being displayed:

- **One variable per field** — it iterates `$entity->getFields()` and adds `$context[$field_id] =
  $value`, where `$value` is the field's **`FieldItemList` object**. So templates read the value via
  the item-list API, e.g. `{{ field_x.value }}`, `{{ field_x.0.value }}`, `{{ field_x.entity.label }}`
  for entity references, or by looping `{% for item in field_x %}`.
- **`label`** — the current field's label. If the `field_display_label` module is enabled and a
  `display_label` third-party setting is present on the field, that override is used; otherwise
  `$this->fieldDefinition->getLabel()`.

It then renders:

```php
$markup = $this->twig->createTemplate($this->getSetting('custom_twig_markup'))->render($context);
```

`$this->twig` is the injected **`twig`** service (`Drupal\Core\Template\TwigEnvironment`).
The result is returned as a single render element:

```php
$elements = [
  '#type'   => 'markup',
  '#markup' => $markup,
  // plus metadata: #view_mode, #language, #field_name, #field_type,
  // #field_translatable, #entity_type, #bundle, #object, #items,
  // #formatter, #is_multiple, #third_party_settings
];
```

For a `file` field it additionally attaches the `file/drupal.file` library. Note the formatter emits
markup **once per field** (not once per delta) — the loop over deltas, if any, must be written inside
your Twig, using the multi-value item list.

## Gotchas

- **Dead error handler.** `viewElements()` wraps the render in `catch (Twig_Error $error)`. That is
  the legacy **Twig 1** class name; under Drupal's Twig 3 the thrown class is `\Twig\Error\Error`, so
  the catch never matches and a broken template surfaces as an uncaught error rather than a messenger
  warning. Test templates before saving.
- Variables are **item-list objects**, not scalars — `{{ field_x }}` renders the list's default
  string cast (often empty or an array notice); use `{{ field_x.value }}` / `{{ field_x.0.value }}`
  or the appropriate property.
- The two "Replacement patterns" panels are informational only; they do not change what is available
  (the render context always contains every field on the entity plus `label`).
- The Twig string lives in exported configuration; changing display formatting is a config change,
  reviewable in `core.entity_view_display.*` diffs.
