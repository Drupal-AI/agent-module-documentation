# Markup field group formatter

Plugin id `markup` (class `Drupal\field_group_markup\Plugin\field_group\FieldGroupFormatter\Markup`),
supported contexts: `form` and `view`. Provided as a `@FieldGroupFormatter` — it is an
implementation for the `field_group` module, not a new plugin type.

## Add via UI
1. Go to an entity display, e.g. *Structure → Content types → [type] → Manage form display*
   (or *Manage display*).
2. Click **Add field group** (a field_group feature), give it a label/machine name.
3. Set **Format** to **Markup** and save.
4. In the group's format settings, fill the **Markup** rich-text field and pick a text format.

## Settings keys
Stored in the display config entity under the group's `format_settings`. Defaults come from
`Markup::defaultContextSettings()`:

| Key | Default | Meaning |
|---|---|---|
| `markup` | `{value: '', format: NULL}` | `text_format` value: `value` = HTML source, `format` = text-format machine name applied via `#type => processed_text` |
| `show_empty_fields` | `TRUE` | Render the element even when it wraps no populated fields (`#show_empty_fields`) |
| `classes` | `form-wrapper` | Space-separated CSS classes added to the wrapper `#attributes` |
| `id` | (from base) | Optional HTML id; passed through `Html::getUniqueId()` |

Base Field Group settings (label, element wrapper, etc.) also apply.

## Behavior notes
- The text is run through `\Drupal::token()->replace($text)` before rendering, so tokens
  (e.g. `[node:title]`, `[current-user:name]`) resolve against the rendered object.
- Output is a `processed_text` render element filtered by the chosen text format — HTML is
  only as permissive as that format allows (choose the format to control XSS exposure).
- Wrapper is `#type => field_group_html_element`, `#wrapper_element => div`.
- Config schema: `field_group.field_group_formatter_plugin.markup` (in
  `config/schema/field_group_markup.field_group_formatter_plugin.schema.yml`).

## Example (display config YAML fragment)
```yaml
third_party_settings:
  field_group:
    group_intro:
      label: Intro
      format_type: markup
      format_settings:
        markup:
          value: '<p>Editing [node:title]</p>'
          format: basic_html
        show_empty_fields: true
        classes: 'form-wrapper intro-box'
```
