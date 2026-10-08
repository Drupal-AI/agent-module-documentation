# Configure BugHerd

Settings form: `\Drupal\bugherd\Form\SettingsForm` (form id `bugherd_settings_form`),
route `bugherd.settings_form` at `/admin/config/development/bugherd`
(permission `administer bugherd`, `_admin_route: TRUE`). Menu link
`bugherd.settings_form` under *Configuration → Development* (`system.admin_config_development`).

Editable config object: **`bugherd.settings`** (schema `bugherd.settings`, all keys shipped
by `config/install/bugherd.settings.yml`). Saving the form invalidates the `bugherd` cache tag.

## Config keys

| Key | Type | Default | Form field | Meaning |
|---|---|---|---|---|
| `bugherd_project_key` | string | `''` | textfield (maxlength 128) | BugHerd project API key; required — no key ⇒ widget not attached. |
| `bugherd_disable_on_admin` | bool | `false` | checkbox | If TRUE, skip attaching on admin routes. |
| `reporter_email_autofill` | bool | `true` | checkbox | If TRUE and user is authenticated, prefill reporter email with the current user's own email. |
| `email_required` | bool | `true` | checkbox | Sets `reporter.required` in the widget config. |
| `bugherd_widget_position` | string | `bottom-right` | select | Widget tab position; only `bottom-right` or `bottom-left`. |
| `tab_text` | string | `''` | textfield | Label override → `feedback.tab_text`. |
| `option_title_text` | string | `''` | textfield | Label override → `feedback.option_title_text`. |
| `option_pin_text` | string | `''` | textfield | Label override → `feedback.option_pin_text`. |
| `option_site_text` | string | `''` | textfield | Label override → `feedback.option_site_text`. |
| `feedback_entry_placeholder` | string | `''` | textfield | Label override. |
| `feedback_email_placeholder` | string | `''` | textfield | Label override. |
| `feedback_submit_text` | string | `''` | textfield | Label override. |
| `confirm_success_text` | string | `''` | textfield | Label override. |
| `confirm_loading_text` | string | `''` | textfield | Label override. |
| `confirm_close_text` | string | `''` | textfield | Label override. |
| `confirm_error_text` | string | `''` | textfield | Label override. |
| `confirm_retry_text` | string | `''` | textfield | Label override. |
| `confirm_extension_text` | string | `''` | textfield | Label override. |
| `confirm_extension_link_text` | string | `''` | textfield | Label override. |

The 14 label keys are enumerated by the static helper
`SettingsForm::getFeedbackLabelParams()` (used both to build the form and to read the
values back in `hook_page_attachments()`). Only **non-empty** label values are emitted into
the widget config. The label overrides apply to BugHerd's *public feedback* tab (see the
BugHerd docs linked from the form); the widget position and labels do not affect the
reviewer sidebar which is controlled by the project's own BugHerd settings.

## Set via drush / PHP

```bash
drush config:set bugherd.settings bugherd_project_key 'YOUR_PROJECT_KEY' -y
drush config:set bugherd.settings bugherd_disable_on_admin true -y
```

```php
\Drupal::configFactory()->getEditable('bugherd.settings')
  ->set('bugherd_project_key', 'YOUR_PROJECT_KEY')
  ->set('bugherd_widget_position', 'bottom-left')
  ->set('email_required', TRUE)
  ->save();
// The form also invalidates the 'bugherd' cache tag on save; do the same if you
// bypass the form: \Drupal::service('cache_tags.invalidator')->invalidateTags(['bugherd']);
```

After setting the key, grant `access bugherd` to the roles that should receive the widget
(see permissions/permissions.md).
