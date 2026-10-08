# Configure View Password

## Settings form

Route `password.route` at `/admin/config/system/view-password-settings`
(**Admin → Configuration → System → View Password Settings**), gated by the
`administer view password` permission. Menu link `password.config` lives under
`system.admin_config_system`. Form class: `Drupal\view_password\Form\PasswordSettingsForm`
(a `ConfigFormBase`, form ID `password_settings_form`).

All values are stored in the `view_password.settings` config object (schema:
`config/schema/view_password.schema.yml`), so they export/deploy with
`drush config:export`.

| Config key | Form field | Default | Meaning |
|---|---|---|---|
| `form_ids` | "Enter the form id(s) here." (textarea) | `user_login_form` | Comma-separated list of form IDs that get the toggle. **No spaces allowed** between IDs. |
| `span_classes` | "Enter the form class here." (textarea) | `''` | Extra space-separated CSS classes added to the toggle `<button>`. |
| `icon_hidden` | Path to the hidden-password SVG (textfield) | `''` | Root-relative path (must start with `/`) to a custom "eye closed" icon; falls back to the module's `eye-close` icon. |
| `icon_exposed` | Path to the exposed-password SVG (textfield) | `''` | Root-relative path (must start with `/`) to a custom "eye open" icon; falls back to the module's `eye-open` icon. |

## How a form is selected

`view_password_form_alter()` (in `view_password.module`) reads `form_ids`, explodes on
`,`, and for each `$form_id` that matches:
- adds cache tag `config:view_password.settings` to the form,
- adds the `pwd-see` class to `$form['#attributes']['class']` (this class scopes the JS so
  only chosen forms are affected),
- attaches the `view_password/pwd_lb` library,
- passes `span_classes`, `icon_exposed`, `icon_hidden`, and the `Show password` /
  `Hide password` labels into `drupalSettings.view_password`.

## Validation (settings form)

- `form_id_pwd`: each comma-separated value is checked with `preg_match('/\s/')` — any
  whitespace triggers "The form ids should contain values separated by commas only."
- `icon_hidden` / `icon_exposed`: if non-empty and not starting with `/`, an error is set
  ("The path ... should start with a trailing slash (/).").

## Drush

Set values without the UI, e.g.:

```
drush cset view_password.settings form_ids "user_login_form,user_register_form"
```
