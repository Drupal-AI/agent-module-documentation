<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The user selection handler override

Source: `src/Plugin/EntityReferenceSelection/ReferenceAllUsers.php`
(`final class ReferenceAllUsers extends UserSelection`).

```php
#[EntityReferenceSelection(
  id: "default:reference_blocked_users",
  label: new TranslatableMarkup("Reference Blocked Users"),
  entity_types: ["user"],
  group: "default",
  weight: 10
)]
```

2.x uses the modern `#[EntityReferenceSelection]` PHP attribute (not the deprecated
annotation) and targets Drupal 11.3+/12.

## Why it applies automatically

Drupal's `SelectionPluginManager::getPluginId($target_type, 'default')` collects every selection
plugin registered for the target entity type in the requested group and returns the
**highest-`weight`** one. Core's `UserSelection` is `default:user` with weight 0; this plugin is
weight 10 in the same `default` group for `user`, so it becomes the effective handler for **all**
user reference fields (including `node.uid` "Authored by") **without any field configuration**.
The weight alone wins the election.

## What it changes

Two methods are overridden.

`create()` reimplements the parent constructor injection (entity_type.manager, module_handler,
current_user, database, entity_field.manager, entity_type.bundle.info, entity.repository) purely
to declare a native `: static` return type — a forward-compatibility fix for `DebugClassLoader`
warnings, with no behavioural change.

`buildEntityQuery()` delegates to the parent (unchanged active-users-only behaviour) unless the
current user lacks `administer users` yet holds `reference blocked users`, in which case it calls
`buildEntityQueryForAllUsers()`:

```php
$query = $this->entityTypeManager->getStorage('user')->getQuery();
$query->accessCheck(TRUE);                            // still access-checked
if (!$configuration['include_anonymous']) {
  $query->condition('uid', 0, '<>');                  // drop anonymous if configured
}
if (isset($match)) {                                  // match username OR email
  $group = $query->orConditionGroup()
    ->condition('name', $match, $match_operator)
    ->condition('mail', $match, $match_operator);
  $query->condition($group);
}
if (!empty($configuration['filter']['role'])) {
  $query->condition('roles', $configuration['filter']['role'], 'IN');
}
$query->condition('status', 0, '>=');                 // KEY: includes blocked (0) and active (1)
```

Two substantive differences from core's non-admin path:
- **`status >= 0`** returns active **and** blocked accounts (core forces `status = 1`).
- The `$match` clause is an OR over **`name` and `mail`**, so editors can find a user by email
  fragment (core matches `name` only). All conditions use the parameterized entity query API.

## Overriding / interacting

- To change behaviour, subclass `ReferenceAllUsers` (or core `UserSelection`) and register your own
  `default:*` plugin for `user` with a higher `weight`.
- A field can still opt out by explicitly setting its handler to `default:user` in
  `field.field.*.handler`, which the weight-based default does not override when a handler is set
  explicitly.
- The `filter[role]` and `include_anonymous` settings come from the field's normal reference
  handler settings and are respected here.

## Tests

`tests/src/Kernel/ReferenceBlockedUsersSelectionTest.php` (kernel, `EntityKernelTestBase`) asserts:
a permission holder sees active and blocked users; a user without the permission does not see
blocked users; and an email fragment matches a user whose username does not contain it.
