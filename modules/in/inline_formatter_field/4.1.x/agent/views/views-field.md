# Inline Formatter Views Field submodule

`inline_formatter_views_field` (package `views`, depends on `drupal:views` and
`inline_formatter_field`) adds a Views field that renders an HTML/Twig template — a richer
alternative to core's "Custom text" field, using the Ace editor for authoring.

## Views registration — `hook_views_data`

`inline_formatter_views_field.views.inc` registers, in the **Global** group, a field
`views.inline_formatter`:

```php
$data['views']['inline_formatter'] = [
  'title' => t('Inline Formatter'),
  'help'  => t('Provide custom HTML or Twig.'),
  'field' => ['id' => 'inline_formatter_views_field', 'click sortable' => FALSE],
];
```

Add it to any View as "Global: Inline Formatter".

## The field plugin — `inline_formatter_views_field`

`Plugin/views/field/InlineFormatterViewsField` (`@ViewsField("inline_formatter_views_field")`,
extends `FieldPluginBase`). `query()` is a no-op (nothing added to the SQL query).

`defineOptions()`/`buildOptionsForm()` store the template in option
`inline_formatter_field_display` = `{value, format}` (default `<h1>Hello World!</h1>`). The
`text_format` editor is shown only to users with permission `edit inline formatter views field`;
others see a warning. A copy of the Views "Replacement patterns" help is shown so authors know which
`{{ token }}` field replacements are available.

### `render(ResultRow)` pipeline

1. Render the template through `#type => processed_text` (its filter format).
2. If the template contains `{{`, collect the row's Views replacement tokens from the **last** field
   in the view (`$last_field->last_tokens` or `->getRenderTokens($fake_item)`) and expand them into a
   nested `$context` array via `getContextFromTokens()` — so Views field tokens like
   `{{ title }}` / `{{ field_x }}` become **Twig context variables** (validated against the PHP/Twig
   identifier regex with `assert()`).
3. `token->replace($template, [], ['clear' => $clear_tokens])` — note the token **data is empty**, so
   only *global* tokens (`[site:name]`, `[current-date:*]`, …) are replaced here; entity/row tokens
   are handled via the Twig context in step 2.
4. `hook_inline_formatter_views_field_context_alter(&$context)` runs.
5. Render as `#type => inline_template` (`#template` = the string, `#context` = the expanded tokens)
   and return `ViewsRenderPipelineMarkup::create((string) $rendered)`.

## Notes

- Placement matters: the plugin pulls row tokens from `end($this->view->field)`, i.e. the last field
  in the display — put this field **after** the fields whose `{{ token }}` values it references.
- Unlike core "Custom text", output is not run through the restrictive default filter; the
  authoring filter format governs what HTML survives, so restrict `edit inline formatter views field`
  to trusted roles (README).
