# Configure the HTML Formatter formatters

No global settings page (`configure` null). On an entity's **Manage display** tab
(`admin/structure/…/display`) set a compatible field's *Format* to the matching HTML Formatter,
then open the formatter cog to set `tag`, `class` and `link`. Settings persist in the
`entity_view_display` config entity.

Source: `src/Plugin/Field/FieldFormatter/*.php`, shared `src/Plugin/HtmlFormatterTrait.php`,
template `templates/html-formatter.html.twig`.

## The four formatters

| Formatter id | Extends (core) | Field types |
|---|---|---|
| `html_field_formatter` | `FormatterBase` | `text`, `text_long`, `text_with_summary`, `string`, `string_long` |
| `html_field_formatter_datetime_default` | `DateTimeDefaultFormatter` | `datetime` |
| `html_field_formatter_timestamp` | `TimestampFormatter` | `timestamp`, `created`, `changed` |
| `html_field_formatter_entity_reference_label` | `EntityReferenceLabelFormatter` | `entity_reference` |

The three date/reference formatters first call their parent's `viewElements()` (so they inherit
the parent's own settings, e.g. date format / link-to-entity for entity reference) and then
re-theme each element through the `html_formatter` template. The plain `html_field_formatter`
outputs the raw field `value` directly.

## Settings (defaults from `getHtmlFormatterDefaultSettings()`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `tag` | textfield | `''` | HTML element name to wrap the value in (`h2`, `div`, `article`, …). **Blank ⇒ no wrapper element at all** (template renders only the value). |
| `class` | textfield | `''` | CSS class added to the wrapper's `class` attribute. Blank ⇒ no class. |
| `link` | checkbox | `FALSE` | Wrap the value in a link to the host entity's canonical URL (`getLinkedValue()` uses the `link_formatter_link_separate` theme; only applies when the entity is saved and has a canonical link template). |

Stored as:

```
core.entity_view_display.<entity>.<bundle>.<view_mode>:
  content:
    <field_name>:
      type: html_field_formatter            # or *_datetime_default / *_timestamp / *_entity_reference_label
      settings: { tag: 'h2', class: 'title', link: false }
```

Schemas: `field.formatter.settings.html_field_formatter` (plain), and the date/reference variants
which *inherit* the corresponding core formatter schema and add the same `tag`/`class`/`link` keys.

## The template

`html-formatter.html.twig`:

```twig
{% if tag %}<{{ tag }}{{ attributes }}>{% endif %}
    {{ value }}
{% if tag %}</{{ tag }}>{% endif %}
```

`#attributes` carries the `class`. Note the plain `html_field_formatter` passes `class` as
`['class' => [$class]]`, while the date/reference variants set `#attributes['class']` to the raw
string — both end up on the wrapper.

## Set a formatter with code (example)

```php
// drush php:eval — render node.article field_subtitle as <h2 class="subtitle">, linked to the node.
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$vd->setComponent('field_subtitle', [
  'type' => 'html_field_formatter',
  'region' => 'content',
  'settings' => ['tag' => 'h2', 'class' => 'subtitle', 'link' => TRUE],
])->save();
```

## Trust responsibility (read before using on rich text)

This is a wrapper formatter, not a text-format renderer. Two things to be aware of:

- **`tag` and `class` come straight from admin config** and are interpolated into markup
  (`<{{ tag }}…>`). Anyone who can edit the entity display (typically `administer <entity> display`)
  chooses them. Grant that permission only to trusted roles — as with any Drupal display config.
- **The plain `html_field_formatter` emits `$item->value` (the raw stored value)** and does **not**
  run the field's text-format filter (`check_markup`). For `text_long`/`text_with_summary` fields
  that normally rely on a format's filtering, this bypasses that pipeline. The value is passed
  through Drupal's theme layer (Twig), but do not treat this formatter as sanitizing untrusted
  markup. Use it on fields whose content is authored by trusted roles, or on plain `string`
  fields where no HTML is expected.
