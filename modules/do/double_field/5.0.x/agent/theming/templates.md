<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming

`Hook\Theme\Theme` (a `#[Hook('theme')]` class) registers two theme hooks, both using
`render element: elements` and a Drupal 11.3 **`initial preprocess`** class rather than a
`template_preprocess_*` function.

| Theme hook | Template | Initial preprocess | Used by |
|---|---|---|---|
| `double_field_item` | `double-field-item.html.twig` | `Hook\Theme\PreprocessDoubleFieldItem` | Unformatted List, HTML List (`ul`/`ol`) |
| `double_field_definition_list` | `double-field-definition-list.html.twig` | `Hook\Theme\PreprocessDoubleFieldDefinitionList` | HTML List when `list_type: dl` |

The Details and Table formatters do **not** use these hooks — they render core's `details` and
`table` elements and only add theme *suggestions*.

## `double_field_item`

Variables reaching the template: `item` (iterated as `subfield => subitem`), `settings`,
`field_settings`, `field_name`.

```twig
{% for subfield, subitem in item %}
  {% if subitem -%}
    <div class="double-field-{{ subfield }}">
      {%- if field_settings.storage[subfield].type == 'text' -%}
        {{- subitem|nl2br -}}
      {%- else -%}
        {{- subitem -}}
      {%- endif -%}
    </div>
  {% endif %}
{% endfor %}
```

So each subfield lands in `div.double-field-first` / `div.double-field-second`, and a `text`
subfield gets `nl2br` applied.

## `double_field_definition_list`

```twig
<dl class="double-field-definition-list">
  {% for item in items %}
    <dt>{{ item.first }}</dt>
    <dd>{{ item.second }}</dd>
  {% endfor %}
</dl>
```

## Theme suggestions (all per-field-name)

| Base hook | Suggestion added | Added by |
|---|---|---|
| `double_field_item` | `double_field_item__<field_name>` | `ThemeSuggestionsDoubleFieldItem` |
| `double_field_definition_list` | `double_field_definition_list__<field_name>` | `ThemeSuggestionsDoubleFieldDefinitionList` |
| `table` | `table__double_field__<field_name>` | `ThemeSuggestionsTableAlter` |
| `item_list` | `item_list__double_field__<field_name>` | `ThemeSuggestionsItemListAlter` |
| `details` | `details__double_field__<field_name>` | `ThemeSuggestionsDetailsAlter` |

The Table and Details formatters pass the field name to the theme layer through a
**custom HTML attribute**, `double-field--field-name`, set on the element's `#attributes`
(there is no other context channel for those core hooks); the item_list suggestion instead reads
`#context.double_field.field_name`. Override files therefore look like
`mytheme/templates/table--double-field--field-specs.html.twig` (Twig converts `_` to `-`).

## CSS classes and libraries

`double_field.libraries.yml` defines one library, `double_field/widget` (`css/widget.css`), used
for the edit form's inline layout. Output classes worth targeting:

- `.double-field-unformatted-list`, `.double-field-list`, `.double-field-table`,
  `.double-field-details`, `.double-field-definition-list`
- `.double-field-first`, `.double-field-second`
- `.container-inline` — added per item/wrapper when the formatter's `inline` setting is on
