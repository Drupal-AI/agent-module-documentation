# Hooks — ldap_authentication

Declared in `ldap_authentication.api.php`.

## `hook_ldap_authentication_allowuser_results_alter(Entry $ldap_user, string $name, bool &$hook_result)`

Approve or deny a login after the credentials have matched an LDAP entry but before the Drupal
account is finalised. Inspect the Symfony `Entry` (`$ldap_user`) and the proposed/actual Drupal
account `$name`, then set `$hook_result` by reference: `TRUE` = allow, `FALSE` = deny.

Be a good citizen: if another module has already set `$hook_result` to `FALSE`, return early
rather than re-allowing.

```php
function mymodule_ldap_authentication_allowuser_results_alter(Entry $ldap_user, string $name, bool &$hook_result) {
  if (!$hook_result) {
    return; // Already denied by someone else.
  }
  if (mymodule_disapproves($ldap_user, $name)) {
    $hook_result = FALSE;
  }
}
```
