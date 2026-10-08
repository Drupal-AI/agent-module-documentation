<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ExternalRolesUser wrapper

File: `src/ExternalRolesUser.php`
Class: `Drupal\external_roles\ExternalRolesUser`. Plain class — **not** a service; instantiate directly with a
`\Drupal\user\UserInterface`: `new ExternalRolesUser($user)`.

Reads and mutates the `external_roles` base field on a user entity. Every method first checks
`$this->user->hasField('external_roles')` and no-ops (returns `[]` / `$this`) if the field is missing.

## Methods

- `hasExternalRole(string $role): bool` — `in_array($role, $this->getExternalRoles(), TRUE)`.
- `getExternalRoles(): string[]` — `array_column($user->get('external_roles')->getValue(), 'value')`.
- `addExternalRole(string $role): static` — appends `$role`, sets the field to `array_unique($roles)`.
- `removeExternalRole(string $role): static` — sets the field to `array_diff(current, [$role])`.
- `resetExternalRoles(): static` — sets the field to `[]`.

The mutators are fluent (`return $this`) and only change the in-memory entity; **you must save the user**
(or use them inside a presave hook) for changes to persist to `user__external_roles` and be picked up by the
`external_roles` service.

## Typical usage

Assign roles from your business logic, e.g. `hook_user_presave()`:

```php
function my_module_user_presave(\Drupal\user\UserInterface $user): void {
  $wrapped = new \Drupal\external_roles\ExternalRolesUser($user);
  $wrapped->addExternalRole('alpha')->addExternalRole('beta');
}
```

For OpenID Connect, `hook_openid_connect_userinfo_save()` is a natural place — map the identity provider's
reported roles (validate first) onto external roles. See [extending.md](extending.md).
