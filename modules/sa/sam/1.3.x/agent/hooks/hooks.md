# Hooks — `sam.api.php`

SAM invites exactly one hook.

## `hook_sam_allowed_widget_types_alter(array &$widget_types)`

Alter the list of field widget plugin ids that SAM is allowed to simplify. The base list is
`SAM_ALLOWED_WIDGET_TYPES` in `sam.module` (text/textarea, email, number, telephone, link,
path, uri, entity_reference_autocomplete, linkit, …). Add your own widget id to opt it in.

```php
/**
 * Implements hook_sam_allowed_widget_types_alter().
 */
function mymodule_sam_allowed_widget_types_alter(array &$widget_types) {
  $widget_types[] = 'my_custom_widget';
}
```

The module docblock warns: if you add a widget here, you are responsible for making sure
SAM's show/hide-and-remove JS behaves correctly with that widget's markup.

---

SAM does not define services or plugins. Its own behavior is wired through these core hook
implementations (in `sam.module`), listed for orientation — you implement them only if you
are decorating SAM's output:

- `hook_field_widget_complete_form_alter()` — flags surplus empty deltas with
  `data-sam-simplify` and the wrapper with `data-sam-wrapper-simplify`.
- `hook_preprocess_field_multiple_value_form()` — adds the `sam-simplify` /
  `sam-wrapper-simplify` classes, attaches the `sam/simplify` library, and passes the
  configured labels/help text to `drupalSettings.sam`.
- `hook_field_widget_third_party_settings_form()` — adds the per-widget "skip simplification"
  checkbox (see [../configure/settings.md](../configure/settings.md)).
