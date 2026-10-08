# Label Help — the `#label_help` Form API property

For forms you build in code (that are **not** driven by a `field_config`), set help text directly on a
form element with the `#label_help` property. `label_help_process_form()` checks this first
(`if (!empty($item['#label_help']))`) before falling back to the field's stored third-party setting.

```php
function mymodule_form_alter(&$form, FormStateInterface $form_state, $form_id) {
  $form['email']['#label_help'] = t('We only use this to send booking confirmations.');
}
```

- Works on any form element that Label Help's placement cascade can handle (the same ~18 widget
  "use cases" that the UI path uses).
- The text is rendered through the themeable `label_help` render element, so it picks up the
  Seven/Claro/Gin styling automatically.
- No storage is involved on this path — the property lives only for that form build; it does not touch
  `field_config` third-party settings.

This is the whole programmatic API. The module exposes no services and no Drush commands; everything
else is the field-config third-party setting documented in
[../configure/label-help.md](../configure/label-help.md).
