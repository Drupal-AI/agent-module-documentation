# A11Y: Form Helpers — settings

Config object `a11y_form_helpers.settings` (schema `config/schema`), all keys default TRUE
(`config/install`). Settings form `A11yFormHelpersSettingsForm` at
`/admin/config/content/a11y_form_helpers`, route `a11y_form_helpers.settings`, permission
`configure a11y_form_helpers` (`restrict access: true`). Uses `#config_target`, so checking a box writes
the matching key.

| Key | Default | Effect |
|---|---|---|
| `features.no_html5_validation` | true | `hook_form_alter` sets `$form['#attributes']['novalidate'] = 'novalidate'` on **every** form, so browsers skip native HTML5 validation and Drupal / Inline Form Errors handle it. |
| `features.readable_error_messages` | true | A `#pre_render` (added to all render elements via `hook_element_info_alter`) sets `aria-describedby` to `<id>--errormessage`; `hook_preprocess_form_element` / `_fieldset` pass `errors` + `errormessage_id` to the templates. |
| `features.replace_core_templates` | true | `hook_theme_registry_alter` repoints core's `form_element` and `fieldset` templates at this module's copies (needed for the readable-error markup to render). |

Read a value in code:

```php
\Drupal::config('a11y_form_helpers.settings')->get('features.no_html5_validation');
```

Notes:
- `readable_error_messages` only produces visible/associated error output when
  `replace_core_templates` is on (or your theme's own templates render the `errors` variable).
- Hook ordering: `a11y_form_helpers_module_implements_alter` moves this module's `element_info_alter`,
  `form_alter`, `theme_registry_alter`, and `preprocess_form_element` implementations to the end so they
  win over other modules/themes.
- `update_10000` backfills the three keys to TRUE on sites that predate them.
