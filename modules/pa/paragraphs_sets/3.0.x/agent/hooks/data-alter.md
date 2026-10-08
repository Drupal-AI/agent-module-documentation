# Paragraphs Sets alter hooks

A set's `data` handles primitive default field values directly. For **complex** field values
(references, multi-value, computed) or dynamic defaults, implement one of these hooks
(documented in `paragraphs_sets.api.php`). All receive `&$data` (the default field values for
the paragraph bundle being built) and a `$context` array.

## `$context` keys

`field` (field being operated on), `form`, `form_state`, `key` (internal paragraph key in the
set), `paragraphs_bundle` (the paragraph type), `set` (machine name of the set).

## The hooks (most general → most specific)

```php
/**
 * Implements hook_paragraphs_set_data_alter().
 * Alter default field data for ALL sets.
 */
function my_module_paragraphs_set_data_alter(array &$data, array $context) {
  // $context['set'], $context['paragraphs_bundle'], $context['field'] ...
}

/**
 * Implements hook_paragraphs_set_SET_data_alter().
 * Alter default data for one specific set (SET = the set's machine id).
 */
function my_module_paragraphs_set_landing_data_alter(array &$data, array $context) {
}

/**
 * Implements hook_paragraphs_set_SET_FIELD_NAME_data_alter().
 * Alter one specific field's default within one specific set.
 */
function my_module_paragraphs_set_landing_field_body_data_alter(array &$data, array $context) {
}
```

`SET` is the set's machine name; `FIELD_NAME` is the field machine name (both interpolated into
the hook name). These fire while the widget builds the paragraphs for a chosen set, so you can
inject complex/dynamic default values that cannot be expressed as static `data` in the config.

## Icon hook

```php
/**
 * Implements hook_paragraphs_sets_set_static_icon_uri_alter().
 * Override the icon URI shown for a set in the selector.
 */
function my_module_paragraphs_sets_set_static_icon_uri_alter(string &$uri, \Drupal\paragraphs_sets\ParagraphsSetInterface $paragraphs_set) {
  if ($paragraphs_set->id() === 'landing') {
    $uri = 'public://images/library/landing.png';
  }
}
```

Remember `drush cr` after adding a hook implementation so it is discovered.
