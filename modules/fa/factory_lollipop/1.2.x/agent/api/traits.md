<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Traits

Three reusable traits in `src/Traits/`. They are test/developer helpers; the built-in FactoryTypes use
them internally, and your own FactoryTypes/tests can `use` them too. Both `RandomGeneratorTrait` and
`EntityReferenceTestTrait` carry `// phpcs:ignoreFile` because they mirror core test traits (whose
`\Drupal\Tests` namespace is not autoloaded outside tests).

## RandomGeneratorTrait

`src/Traits/RandomGeneratorTrait.php`. Wraps `Drupal\Component\Utility\Random` (lazily created in
`getRandomGenerator()`).

- `randomString($length = 8)` — pseudo-random ASCII string. For `$length >= 4` it injects a `>&`
  sequence so the value exercises HTML-escaping in tests. Non-CSPRNG by design; this is **test-fixture
  randomness**, not for tokens/passwords.
- `randomMachineName($length = 8)` — random letters+numbers, safe for machine names.
- `randomObject($size = 4)` — a stdClass with random keys/values.
- `randomStringValidate($string)` — callback rejecting strings with consecutive/edge spaces.

## UserCreationTrait

`src/Traits/UserCreationTrait.php` (mirrors `Drupal\Tests\user\Traits\UserCreationTrait`,
`@SuppressWarnings(PHPMD)`). Meant to be used only by test classes / test-time FactoryTypes; used by
`UserFactoryType` and `RoleFactoryType`.

- `setUpCurrentUser(array $values = [], array $permissions = [], $admin = FALSE)` — creates user 1 if
  needed, then a regular user, ensures the anonymous account exists, and sets the current user. Throws
  `\LogicException` if you try to give the anonymous account roles.
- `createUser($permissions = [], $name = NULL, $admin = FALSE, $values = [])` — creates a user
  (optionally with a new role for the permissions, optionally admin), asserts creation, and stashes the
  raw password on `pass_raw`/`passRaw` for login.
- `createAdminRole($rid = NULL, $name = NULL, $weight = NULL)` — creates a role flagged `isAdmin`.
- `createRole(array $permissions, $rid = NULL, $name = NULL, $weight = NULL)` — validates permission
  names (`checkPermissions()` against `user.permissions`), creates the role and grants them.
- `grantPermissions(RoleInterface $role, array $permissions)` — grants and `trustData()->save()`.
- `setCurrentUser(AccountInterface $account)` — switches `\Drupal::currentUser()`.

These create real users/roles/admin roles, but only when your test/CLI code calls them — there is no
request path that reaches them.

## EntityReferenceTestTrait

`src/Traits/EntityReferenceTestTrait.php` (mirrors `Drupal\Tests\field\Traits\EntityReferenceTestTrait`).

- `createEntityReferenceField($entity_type, $bundle, $field_name, $field_label, $target_entity_type,
  $selection_handler = 'default', $selection_handler_settings = [], $cardinality = 1)` — creates (if
  absent) an `entity_reference` `FieldStorageConfig` and a `FieldConfig` instance on the bundle. Handy
  for wiring reference fields in test setup without the full field factory blueprint.
