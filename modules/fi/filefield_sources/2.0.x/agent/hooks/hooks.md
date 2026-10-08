# Hooks (`filefield_sources.api.php`)

Two hooks let other modules integrate with File Field Sources.

## `hook_filefield_sources_widgets()`

Return an array of field-widget plugin ids that File Field Sources should attach to. The module's
own implementation returns `['file_generic', 'image_image']`. Add your custom file widget so the
"File sources" settings and runtime sources appear on it:

```php
function mymodule_filefield_sources_widgets() {
  return ['my_custom_file_widget'];
}
```

The invoked list is checked in `filefield_sources_field_widget_third_party_settings_form()`,
`..._settings_summary_alter()` and `..._single_element_form_alter()` — only widgets in the combined
list get the sources UI.

## `hook_filefield_sources_sources_alter(&$sources, $context)`

Alter the sources available for a particular field at build time. `$sources` is the list of source
plugin definitions; `$context` contains `enabled_sources`, `element`, `form_state`. Use it to remove
sources a given user or field shouldn't get:

```php
function mymodule_filefield_sources_sources_alter(&$sources, $context) {
  foreach (array_keys($sources) as $type) {
    if (!\Drupal::currentUser()->hasPermission("use $type filefield source")) {
      unset($sources[$type]);
    }
  }
}
```

## Not a hook: the internal invoker

`filefield_sources_invoke_all($method, &$params)` is an internal helper that calls the static
`$method` (e.g. `settings`, `value`, `process`, `routes`) on each source **plugin class** — it is how
the module fans a call out to all sources, and is not a hook you implement. To add behavior, write a
`FilefieldSource` plugin (see [../plugins/sources.md](../plugins/sources.md)) rather than
implementing this function.
