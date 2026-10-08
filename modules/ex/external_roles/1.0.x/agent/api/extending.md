<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Consuming / extending External Roles

End-to-end recipe for a module that drives Drupal permissions from an external identity source.

## 1. Install / enable

```bash
composer require drupal/external_roles
drush en external_roles -y
```

Enabling adds the `external_roles` base field to the user entity (`hook_entity_base_field_info()`;
`external_roles_update_10000()` installs it on existing sites). No config, no admin page.

## 2. Define the role → permission mapping

Default source is `settings.php`:

```php
$settings['external_roles'] = [
  'alpha' => ['name' => 'Alpha', 'permissions' => ['access foo']],
  'beta'  => ['name' => 'Beta',  'permissions' => ['access foo', 'access bar']],
];
```

Only the `permissions` array is used for calculation. To source the mapping from somewhere else, implement
`ExternalRolesRepositoryInterface` and override the `external_roles.repository` service — see
[repository.md](repository.md).

## 3. Assign external roles to users in code

Use the `ExternalRolesUser` wrapper (see [user-wrapper.md](user-wrapper.md)). Common integration points:

`hook_user_presave()` (changes persist because the entity is about to be saved):

```php
function my_module_user_presave(\Drupal\user\UserInterface $user): void {
  $wrapped = new \Drupal\external_roles\ExternalRolesUser($user);
  $wrapped->addExternalRole('alpha');
}
```

OpenID Connect user-info save (map provider roles, validating each first):

```php
function my_module_openid_connect_userinfo_save(\Drupal\user\UserInterface $account, array $context): void {
  $roles = /* roles from the identity provider */;
  $wrapped = new \Drupal\external_roles\ExternalRolesUser($account);
  foreach ($roles as $role) {
    if (my_module_validate_role($role)) {
      $wrapped->addExternalRole($role);
    }
  }
}
```

If you assign roles outside a presave hook, save the user entity afterwards.

## 4. How permissions are then granted

On permission calculation, `access_policy.external_roles` (`ExternalRolesAccessPolicy`) adds the permissions
that the `external_roles` service resolves for the user's external roles (service → repository). Results are
cached with the `user.external_roles` cache context. See [access-policy.md](access-policy.md) and
[service.md](service.md).

## 5. Rebuild cache on definition changes

Whenever you change the role→permission definition (in `settings.php` or your custom repository's backing
store), rebuild caches:

```bash
drush cr
```

## What you do NOT get

No admin form, route, permission, config object or Drush command ship with this module — it is a code-level
framework. All operation is via `settings.php`/your repository and the `ExternalRolesUser` wrapper.
