<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The external roles repository (primary extension point)

File: `src/ExternalRolesRepository.php` + interface `src/ExternalRolesRepositoryInterface.php`
Default class: `Drupal\external_roles\ExternalRolesRepository` implements `ExternalRolesRepositoryInterface`.
Service id: `external_roles.repository` (no constructor args by default).

The repository is the contract that turns an external role id into a set of Drupal permission machine names.
It is the intended place to plug in your own definition source.

## Interface

```php
interface ExternalRolesRepositoryInterface {
  // Returns string[] of permission machine names for one role id (may be empty).
  public function getPermissionsByRole(string $role): array;
}
```

## Default implementation

`ExternalRolesRepository::getPermissionsByRole()` returns
`$this->loadDefinition()[$role]['permissions'] ?? []`.
`loadDefinition()` reads (and statically caches) `\Drupal\Core\Site\Settings::get('external_roles', [])`,
i.e. the `settings.php` array:

```php
$settings['external_roles'] = [
  '{role}' => [
    'name' => '...',            // human label (informational; not used for permission calc)
    'permissions' => [
      'access foo',
      'access bar',
    ],
  ],
];
```

Only the `permissions` list is consumed by permission calculation. A role absent from the definition returns
`[]` (no permissions).

## Overriding the repository

To source definitions elsewhere (YAML file, config, database, remote system), implement the interface and
override the service in your module's `*.services.yml`. Example (from the module README) reading a YAML file:

```yaml
external_roles.repository:
  class: Drupal\custom_module\ExternalRolesRepository
  arguments: [ '@extension.list.module' ]
```

Your `getPermissionsByRole($role)` returns the permission array for that role from whatever backing store you
choose. Rebuild caches after changing the definition source or its contents.
