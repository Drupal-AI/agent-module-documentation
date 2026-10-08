# Alter hooks

Linkit invokes two plugin-definition alter hooks (no `.api.php` ships; these come from the
plugin managers' `alterInfo()`).

```php
/**
 * Alter matcher plugin definitions.
 * @see \Drupal\linkit\MatcherManager
 */
function hook_linkit_matcher_alter(array &$definitions) {
  // e.g. remove or retarget a matcher.
  unset($definitions['entity:user']);
}

/**
 * Alter substitution plugin definitions.
 * @see \Drupal\linkit\SubstitutionManager
 */
function hook_linkit_substitution_alter(array &$definitions) {
  $definitions['canonical']['label'] = t('Content page');
}
```

Linkit itself also implements `hook_help()` and
`hook_form_editor_link_dialog_alter()` (swaps the link dialog's href field for the `linkit`
autocomplete element and stores the `data-entity-*` attributes) — see `linkit.module`.
