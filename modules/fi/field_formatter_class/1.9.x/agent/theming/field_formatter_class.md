# Theming — how the class reaches the field wrapper

The module does not ship templates or theme hooks. It injects the configured class into the
existing **field template** (`field.html.twig`) wrapper via preprocess.

## Render path

`field_formatter_class_preprocess_field(&$variables)` (and a generic
`field_formatter_class_preprocess(&$variables, $hook)`) run on field render and:

1. Check for `$variables['element']['#third_party_settings']['field_formatter_class']`; if absent,
   do nothing.
2. Read the stored `class` string.
3. Run it through the **token** service: `\Drupal::service('token')->replace($class, [entityType => $object], ['clear' => TRUE])`,
   where `$object` is `$variables['element']['#object']`. Unresolved tokens are cleared.
4. `explode(' ', $class)` — split on spaces into individual classes.
5. `Html::escape()` each one and append to `$variables['attributes']['class'][]`.

So the classes land on the field's **outer wrapper** (the `attributes` printed on
`field.html.twig`'s container `<div>`), alongside Drupal's default `field field--name-… ` classes.

```twig
{# Effective output for a field with class "col-md-6 my-hook" #}
<div class="field field--name-field-foo … col-md-6 my-hook"> … </div>
```

## Widget (Manage form) side

For form/widget rendering, `field_formatter_class_field_widget_complete_form_alter()` copies the
widget's third-party settings and the entity onto
`$field_widget_complete_form['widget']['#third_party_settings']` / `['#object']`, so the same
generic `hook_preprocess()` applies the class to the widget's wrapper.

## Notes for themers

- **Space-separated = multiple classes.** Each token becomes its own class entry.
- **Escaped, not filtered to markup** — values are `Html::escape()`d, and the summary uses
  `Xss::filter()`, so this is a class-string mechanism, not a way to inject markup.
- **No template override needed.** If your theme overrides `field.html.twig`, just ensure it still
  prints `{{ attributes }}` (or `attributes.class`) on the wrapper for the classes to appear.
- The value is dynamic per entity because tokens are resolved against the field's entity at render
  time — good for status/state-driven classes.
