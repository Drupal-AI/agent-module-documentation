<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `hook_saml_sp_drupal_login_user_attributes()`

Declared in `saml_sp_drupal_login.api.inc`. Fires after a successful SAML login, letting you map
IdP attributes onto the Drupal user (roles, profile fields, etc.). **You must save `$user`
yourself** if you change it.

```php
/**
 * Implements hook_saml_sp_drupal_login_user_attributes().
 */
function mymodule_saml_sp_drupal_login_user_attributes(\Drupal\user\UserInterface $user, array $attributes) {
  // $attributes are the SAML assertion attributes from the IdP (keyed by name).
  if (!empty($attributes['department'][0])) {
    $user->set('field_department', $attributes['department'][0]);
  }
  if (!empty($attributes['groups']) && in_array('admins', $attributes['groups'], TRUE)) {
    $user->addRole('administrator');
  }
  $user->save();
}
```

Invoked by `saml_sp_drupal_login_update_user_attributes()`. Notes:

- `$attributes` is the array from `\OneLogin\Saml2\Response::getAttributes()`; values are arrays.
- A deprecated `hook_saml_sp_drupal_login_user_attributes_alter()` variant still fires first for
  backward compatibility — prefer the non-`_alter` hook above.
- Email and language syncing have dedicated config flags (`update_email`, `update_language`); use
  this hook for everything else (roles, custom fields).
