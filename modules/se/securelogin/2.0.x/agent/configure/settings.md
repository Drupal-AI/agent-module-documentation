# Configure Secure Login

Config UI: `/admin/config/people/securelogin` (route `securelogin.admin`, form
`SecureLoginConfigForm`, permission `administer site configuration`). All state lives in the
`securelogin.settings` config object (schema `securelogin.settings`).

## Settings keys

| Key | Type | Default | Meaning |
|---|---|---|---|
| `base_url` | uri (nullable) | `null` | Secure base URL for HTTPS pages. Blank = Drupal determines it automatically (recommended). Must start with `https://` and have no trailing slash. |
| `secure_forms` | bool | `true` | If true, pages containing a secured form are **redirected** to the secure URL (not just the action rewritten). |
| `all_forms` | bool | `false` | If true, **every** form on the site is submitted to the secure URL (overrides the `forms` list). |
| `forms` | sequence | `[user_login_form, user_form, user_register_form, user_pass_reset, user_pass]` | Form IDs / base form IDs to secure. Populated from the checkboxes fed by `hook_securelogin_alter()`. |
| `other_forms` | sequence | `[]` | Extra form IDs (or base form IDs) to secure, entered as a space-separated textfield. |

Note: to match all node add/edit forms use the **base form ID** `node_form`, not a specific
`article_node_form`. Same for other entity forms — list the base form ID.

## Read / write with drush

```bash
# Read the whole config
drush cget securelogin.settings

# Read one key
drush cget securelogin.settings forms

# Secure all forms
drush cset securelogin.settings all_forms true -y

# Add a custom form ID to the secured list (other_forms is a sequence)
drush cset securelogin.settings other_forms.0 my_custom_form -y
```

In PHP:

```php
$config = \Drupal::configFactory()->getEditable('securelogin.settings');
$forms = $config->get('forms');
$forms[] = 'node_form';                 // secure all node forms
$config->set('forms', array_values(array_unique($forms)))->save();
```

## Form-level behaviour

- The config form's `forms` checkboxes are built from `hook_securelogin_alter()` results, so a
  form only appears here if some module advertised it (see `hooks/securelogin-alter.md`).
- The `forms` / `other_forms` checkboxes and textfield are hidden (via `#states`) when
  `all_forms` is ticked.
- Saving invalidates the `rendered` and `http_response` cache tags.
- `base_url` is validated to require an `https://` scheme; an empty value is stored as `NULL`.

## What securing a form does

At `hook_form_alter`, if the form's (base) form ID is in `forms`/`other_forms` or `all_forms`
is TRUE, the module sets `$form['#https'] = TRUE` and calls
`securelogin.manager::secureForm()`. That rewrites `#action` to the secure base URL and, when
`secure_forms` is TRUE and the request is not already HTTPS, redirects the page to HTTPS
(301 for cacheable/GET, 308 otherwise). See `api/manager.md`.
