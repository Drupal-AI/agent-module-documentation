<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragraphs Sets alter hooks

A set's `data` handles primitive default field values directly. For **complex** field values
(references, multi-value, computed) or dynamic defaults, implement one of these hooks (all declared
in `paragraphs_sets.api.php`). They are invoked from `Hook\FormHooks::fieldWidgetCompleteFormAlter()`
via `$moduleHandler->alter(['paragraphs_set_data', 'paragraphs_set_<SET>_data', 'paragraphs_set_<SET>_<FIELD_NAME>_data'], $data, $context)`
while the widget builds a chosen set's paragraphs, so you can inject values that cannot be expressed
as static `data` in config. Each receives `&$data` (the default field values for the paragraph
bundle being built) and a `$context` array. These are classic procedural `hook_*` implementations
(name-matched), independent of the module's own OOP `#[Hook]` classes.

## `$context` keys

`field` (field name being operated on), `form`, `form_state`, `key` (internal index of the paragraph
in the set), `paragraphs_bundle` (the paragraph type), `set` (machine name of the set).

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
function my_module_paragraphs_set_landing_intro_data_alter(array &$data, array $context) {
}

/**
 * Implements hook_paragraphs_set_SET_FIELD_NAME_data_alter().
 * Alter one specific field's default within one specific set.
 */
function my_module_paragraphs_set_landing_intro_field_body_data_alter(array &$data, array $context) {
}
```

`SET` is the set's machine name; `FIELD_NAME` is the (paragraph reference) field machine name — both
are interpolated into the hook name, so `hook_paragraphs_set_<set>_<field_name>_data_alter()` targets
one set on one field. All three names fire (general → specific) for each paragraph the set builds.

## Icon hook

```php
/**
 * Implements hook_paragraphs_sets_set_static_icon_uri_alter().
 * Override the icon URI shown for a set (used by ParagraphsSet::getStaticIconUri()).
 */
function my_module_paragraphs_sets_set_static_icon_uri_alter(string &$uri, \Drupal\paragraphs_sets\ParagraphsSetInterface $paragraphs_set) {
  if ($paragraphs_set->id() === 'landing_intro') {
    $uri = 'public://images/library/landing.png';
  }
}
```

`ParagraphsSet::getIconUrl()` prefers an uploaded icon file (`icon_uuid`); if none, it falls back to
the static URI returned by `getStaticIconUri()`, which fires this alter.

Remember `drush cr` after adding a hook implementation so it is discovered.
