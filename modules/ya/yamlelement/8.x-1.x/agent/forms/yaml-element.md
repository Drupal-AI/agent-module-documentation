# The `yaml` Form API element

`Drupal\yamlelement\Element\Yaml` (annotation `@FormElement("yaml")`, so `#type => 'yaml'`) is a
reusable Form API element. It extends core `Textarea`, so it renders as a `<textarea>` and accepts
all textarea properties (`#rows`, `#cols`, `#placeholder`, `#required`, …) and adds parse / validate
/ dump on top.

## Use it

```php
$form['settings'] = [
  '#type' => 'yaml',
  '#title' => $this->t('Settings (YAML)'),
  '#default_value' => ['foo' => 'bar', 'list' => [1, 2, 3]],
];
```

`#default_value` is a **PHP array/structure**, not a YAML string — the element dumps it to YAML text
for display. After a successful submit, `$form_state->getValue('settings')` is the **parsed PHP
structure**, again not a string. Consuming code therefore reads/writes native PHP values and never
touches YAML text.

## Lifecycle (`src/Element/Yaml.php`)

- `getInfo()` (line 21) — sets `#allow_objects => FALSE`, appends `validateYaml` to
  `#element_validate` and `preRenderYaml` to `#pre_render`.
- `preRenderYaml($element)` (`#pre_render`, line 32) —
  `#value = Yaml::dump($value, 999, 2, $flags)` with
  `DUMP_EXCEPTION_ON_INVALID_TYPE | DUMP_MULTI_LINE_LITERAL_BLOCK`. It is the only entry in
  `trustedCallbacks()` (line 64) — required because it is a `#pre_render` callback on a class
  implementing `TrustedCallbackInterface`.
- `validateYaml($element, $form_state, $form)` (`#element_validate`, line 44) — reads the raw
  submitted string via `$form_state->getValue($element['#parents'])`, calls `Yaml::parse($input,
  $flags)` with `PARSE_EXCEPTION_ON_INVALID_TYPE`; on `ParseException` it sets the form error
  `"The Yaml in %field is not valid."`; on success it **overwrites the element value** with the
  parsed structure via `$form_state->setValue($element['#parents'], $value)`.

## Element property

| Property | Default | Effect |
|---|---|---|
| `#allow_objects` | `FALSE` | Controls object-tag handling in the underlying Symfony YAML parser/dumper. |

Everything else is inherited from core `Textarea`.

## Notes

- The element checks YAML **syntax** only. A structurally valid document that has the wrong keys or
  out-of-range values still passes; validate the parsed shape in your own `#element_validate` or
  submit handler.
- Because the value in `$form_state` is replaced with the parsed structure, do not re-parse it in a
  submit handler — it is already decoded.
