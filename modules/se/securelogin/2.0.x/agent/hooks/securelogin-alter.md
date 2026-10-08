# hook_securelogin_alter()

`hook_securelogin_alter(array &$forms)` lets a module advertise its form IDs so they appear as
**checkboxes** on the Secure Login config form (`/admin/config/people/securelogin`). Without an
implementation a form can still be secured via the free-text "Other forms to secure" field, but
it will not get a labelled checkbox.

Each entry is keyed by the form ID (or base form ID) and provides a `#title`:

```php
/**
 * Implements hook_securelogin_alter().
 */
function mymodule_securelogin_alter(array &$forms) {
  $forms['my_signup_form'] = ['#title' => t('My signup form')];
}
```

The config form reads `$item['#title']` for each entry to build the checkbox label; the checkbox
key is the form ID that gets stored into `securelogin.settings:forms` when ticked.

## Built-in implementations (in `src/Hook/SecureLoginAlter.php`)

Secure Login ships OO hook implementations (attribute `#[Hook('securelogin_alter', ...)]`),
conditional on the relevant module being installed:

| Module | Form IDs advertised |
|---|---|
| user | `user_form`, `user_login_form`, `user_pass`, `user_pass_reset`, `user_register_form` |
| node | `node_form` (base form ID — matches all node add/edit forms) |
| comment | `comment_form` |
| contact | `contact_message_form` |
| webform | `webform_client_form` (Secure Login special-cases `webform_submission_*_form`) |

So a form appears on the settings checklist only when both Secure Login and the owning module
are enabled. For anything else, either implement this hook or add the form ID to `other_forms`.
