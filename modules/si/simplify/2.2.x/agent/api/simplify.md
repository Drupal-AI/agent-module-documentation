# Simplify — hooks (extend the hideable-field list)

Simplify has no services or plugin types. It exposes two alter hooks (`simplify.api.php`) so
other modules can add their own hideable elements and control how each is hidden.

## `hook_simplify_get_fields_alter(array &$fields, $type)`

Add rows to the checkbox list on the settings form (and per-bundle forms). `$fields` is an
associative array `machine_key => human label`; `$type` is one of `nodes`, `users`, `comments`,
`taxonomy`, `blocks` (also `menu_links`, `media`, `eck`, `profiles`).

```php
function mymodule_simplify_get_fields_alter(array &$fields, $type) {
  if ($type === 'nodes') {
    $fields['field_internal_notes'] = t('Internal notes');
  }
}
```

The chosen key is then stored in `simplify_nodes_global` (or the per-bundle `simplify_nodes`)
like any built-in element.

## `hook_simplify_hide_field_alter(array &$form, array $field)`

Runs inside `simplify_hide_field()` for each element being hidden, letting you customise *how* a
given key is removed from the form (default behaviour adds the `visually-hidden` class to
`$form[$key]`).

```php
function mymodule_simplify_hide_field_alter(array &$form, $field) {
  if ($field === 'field_internal_notes') {
    $form['field_internal_notes']['#access'] = FALSE;
  }
}
```

## Built-in hiding mechanics (reference)

`simplify_hide_field()` special-cases a few keys: `path` sets `#access = FALSE`; `meta`,
`revision_information`, `author`, `status`, `domain` and the `menu_*` keys add `visually-hidden`
to specific sub-elements; `format` recurses the form and hides every `text_format` element's
format selector. Everything else falls through to `$form[$key]['#attributes']['class'][] =
'visually-hidden'`.
