# Field type, widget and formatter

The heart of the module: a boolean field plus a template-rendering formatter.

## The three plugins

| Kind | id | Class | Notes |
|---|---|---|---|
| Field type | `inline_formatter_field` | `Plugin/Field/FieldType/InlineFormatterFieldType` | label "Inline Formatter", category `Formatting`. |
| Widget | `inline_formatter_field_widget` | `Plugin/Field/FieldWidget/InlineFormatterFieldWidget` | one checkbox. |
| Formatter | `inline_formatter_field_formatter` | `Plugin/Field/FieldFormatter/InlineFormatterFieldFormatter` | for field types `inline_formatter_field` **and** `boolean`. |

Because the formatter also targets the core `boolean` type, you can attach it to any existing
boolean field to render a template when that boolean is on.

### Storage / value

`InlineFormatterFieldType::schema()` defines a single column `display_format` — `int`, `size tiny`,
default `1`. `propertyDefinitions()` exposes it as a `boolean` property. `isEmpty()` returns empty
unless `display_format == 1`, i.e. the item counts as "present" only when the box is checked.

The widget (`formElement`) renders `display_format` as a `#type => checkbox` titled
"Render the format for &lt;field label&gt;". That is the entire content-form UI for the field.

## Where the template lives

The template is **not** stored per entity — it is a **formatter setting** on the view display.
`defaultSettings()` = `['formatted_field' => ['value' => '<h1>Hello World!</h1>']]`. In
`settingsForm()` (Manage display gear), when the user has permission `edit inline formatter field
formats`, a `#type => text_format` element `formatted_field` is shown, forced to the configured
default editor format (`#format`/`#allowed_formats` = `inline_formatter_field.settings:default_editor`,
normally `iff_ace_editor`). `formattedFieldValidate()` normalizes `\r\n?` → `\n`.

`settingsSummary()` shows the first ~5 lines (truncated at 50 chars) of the stored template.

Config schema: `field.formatter.settings.inline_formatter_field_formatter` →
`formatted_field: {value: string, format: string}`. (Pre-v4 stored `formatted_field` as a bare
string; the class tolerates both, and `inline_formatter_field_update_8005` migrates old configs.)

## Render pipeline (`viewElements`, InlineFormatterFieldFormatter.php:214)

For each field item where `$item->display_format || $item->value` is truthy:

1. Read the formatter setting `formatted_field`. If it is the `{value, format}` array, build a
   `#type => processed_text` render array (`#text` = value, `#format` = the editor/filter format,
   `#langcode`) and render it — this applies the filter format's filters to produce HTML.
2. **Token replacement**: `\Drupal::token()->replace($formatted_field, [<entity_type> => $entity],
   ['clear' => $clear_tokens])`. `$clear_tokens` comes from the editor's `clear_tokens` setting
   (default `FALSE`). So `[node:title]`, `[node:field_x]`, etc. are substituted into the string.
3. `hook_inline_formatter_field_formatter_context_alter(&$context, $entity)` is invoked to let other
   modules extend the context (see [../hooks/context.md](../hooks/context.md)).
4. The result becomes a **Twig `inline_template`**:
   ```php
   $element[$delta] = [
     '#type' => 'inline_template',
     '#template' => $formatted_field,      // token-replaced string
     '#context' => [
       $entity->getEntityTypeId() => $entity,   // e.g. 'node' => $node
       'current_user' => $this->currentUser,
     ],
   ];
   ```

### Twig context available to template authors

- `<entity_type>` — the host entity, keyed by its machine type id (`node`, `media`,
  `block_content`, `user`, `taxonomy_term`, …). Reach fields the normal Twig way, e.g.
  `{{ node.field_price.value }}`, `{{ node.title.value }}`, `{{ node.field_ref.entity.label }}`.
- `current_user` — the `AccountProxy`; e.g. `{% if current_user.hasPermission('administer nodes') %}`.
- Any keys a `*_context_alter` hook adds (the API example adds `label` and `language`).

Use **Twig variables** (`{{ node.title.value }}`) for entity data — Twig auto-escapes those. Drupal
tokens (`[node:title]`) are also supported but are substituted into the template *string* before
Twig compiles it; see the SPDX/README note and treat token-referenced values as part of the template.
Recommended companions (README): `token` (adds a token browser to the Manage-display UI via the AJAX
route) and `twig_tweak` (`drupal_block`, `drupal_entity`, `drupal_field`, `drupal_image`, …).

## Set the formatter from code

```php
\Drupal::service('entity_display.repository')
  ->getViewDisplay('node', 'article', 'default')
  ->setComponent('field_inline', [
    'type' => 'inline_formatter_field_formatter',
    'settings' => [
      'formatted_field' => [
        'value' => "<div class=\"price\">{{ node.field_amount.value }} {{ node.field_currency.value }}</div>",
        'format' => 'iff_ace_editor',
      ],
    ],
  ])->save();
```

Add the field itself the usual way (`field_storage_config` of type `inline_formatter_field`, then a
`field_config` on the bundle). To always render it, set the field's default value checked and move it
to *Disabled* in the form display (README FAQ).
