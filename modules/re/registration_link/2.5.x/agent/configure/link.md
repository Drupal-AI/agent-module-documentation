# The registration link, route, and access check

Registration Link has no config UI. It ships one menu link, one route, and one access checker.

## Menu link (`registration_link.links.menu.yml`)

```yaml
registration_link.user_register:
  title: 'Register'
  route_name: registration_link.register
  menu_name: account       # the user account menu
  weight: 10
```

Manage/move/rename/disable it at *Structure → Menus → Account menu* like any menu link.

## Route (`registration_link.routing.yml`)

```yaml
registration_link.register:
  path: '/user/register'
  defaults:
    _entity_form: 'user.register'
    _title: 'Create new account'
  requirements:
    _registration_link_custom_access: 'TRUE'
    _role: 'administrator+anonymous'
```

It re-declares core's `/user/register` path with the same `user.register` entity form, but gated by both
a `_role` requirement (administrator OR anonymous) and the module's custom access check.

## Access check (`src/Access/RegistrationLinkAccessCheck.php`)

Service `registration_link.registration_link_custom_access`, tagged `access_check`
(`applies_to: _registration_link_custom_access`), constructed with `config.factory` (reads
`user.settings`). Logic:

```php
if (in_array('administrator', $account->getRoles())) {
  return AccessResult::allowed();
}
return AccessResult::allowedIf(
  $account->isAnonymous()
  && $config->get('register') != UserInterface::REGISTER_ADMINISTRATORS_ONLY
)->addCacheableDependency($config); // config = user.settings
```

Consequences:
- **Administrators**: always allowed (link shown, form reachable).
- **Anonymous**: allowed only when core's *Who can register accounts* is Visitors or
  Visitors-with-admin-approval (i.e. not "Administrators only").
- **Authenticated non-admins**: not allowed by this check (they are neither the admin role nor anonymous).
- Access is cache-tagged to `user.settings`, so toggling the core register mode invalidates it correctly.

There is nothing to configure beyond core's account-settings register mode and normal menu-link management.
