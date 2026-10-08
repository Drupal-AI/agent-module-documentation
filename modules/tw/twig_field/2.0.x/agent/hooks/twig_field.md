# Twig Field hooks

Both hooks are declared in `twig_field.api.php` and invoked via `moduleHandler()->alter()`.

## `hook_twig_field_widget_variable_alter(&$options, $alter_context)`

Invoked by `TwigWidget::formElement()` (alter name `twig_field_widget_variable`). Alter the grouped
`#options` of the widget's "Variables" select (groups: `Global`, `Fields`, `Other`). Add your own keys so
editors can insert them.
- `$options` — nested option array (by optgroup).
- `$alter_context` — `['entity_type' => string, 'field_definition' => FieldDefinitionInterface (clone)]`.

## `hook_twig_field_formatter_variable_alter(&$context, $alter_context)`

Invoked by `TwigFormatter::viewElements()` (alter name `twig_field_formatter_variable`). Add/adjust the
Twig `$context` actually passed to the rendered template. Use this to expose extra variables to templates
at render time.
- `$context` — the render context array (globals + per-display fields + host entity) about to be handed
  to `inline_template`.
- `$alter_context` — `['entity_type' => string, 'field_definition' => FieldDefinitionInterface (clone)]`.

Keep the two in sync: add a variable to the formatter context *and* advertise it in the widget picker so
editors know it exists. A working example lives in
`tests/modules/twig_field_alter_hook_test/twig_field_alter_hook_test.module`.
