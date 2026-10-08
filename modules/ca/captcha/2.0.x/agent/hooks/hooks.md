# Hooks — implement or alter a challenge

CAPTCHA has **no plugin type**; challenge types are discovered by invoking `hook_captcha()`
across modules (see `captcha.api.php`). The base module's own "Math" challenge is just an
implementation of this hook (`captcha_captcha()`).

### `hook_captcha($op, $captcha_type = '', $captcha_sid = NULL)`
The one required hook. Return values depend on `$op`:
- `'list'` → array of challenge type names your module offers (e.g. `['Math']`). These show up
  as `yourmodule/Type` in the point/settings selectors.
- `'generate'` → for the given `$captcha_type`, return an array with:
  - `solution` — the correct answer.
  - `form` — form elements to add; must include a `captcha_response` element for the answer.
  - `captcha_validate` (optional) — validation callback name (defaults to
    `captcha_validate_strict_equality`). Others: `captcha_validate_case_insensitive_equality`,
    `captcha_validate_ignore_spaces`, `captcha_validate_case_insensitive_ignore_spaces`.
  - `cacheable` (optional) — TRUE if compatible with a cached form.

```php
function mymodule_captcha($op, $captcha_type = '') {
  switch ($op) {
    case 'list':
      return ['Foo'];
    case 'generate':
      if ($captcha_type == 'Foo') {
        return [
          'solution' => 'foo',
          'form' => ['captcha_response' => [
            '#type' => 'textfield', '#title' => t('Enter "foo"'), '#required' => TRUE,
          ]],
        ];
      }
  }
}
```

### Other hooks
- `hook_captcha_alter(&$captcha, $info)` — modify a generated challenge (e.g. tweak description). `$info` has `module`, `captcha_type`, `form_id`.
- `hook_captcha_placement_map()` — return `form_id => ['path' => [...], 'key' => '...', 'weight' => n]` to control exactly where the CAPTCHA element is inserted in complex forms.
- Custom validation: `hook_captcha_custom_validation($solution, $response)` and the advanced `hook_captcha_custom_advance_validation($solution, $response, $element, $form_state)`.

After adding a hook, `drush cr` so the new type appears in the selectors.
