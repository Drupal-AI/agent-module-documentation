# The user selection handler override

Source: `src/Plugin/EntityReferenceSelection/ReferenceAllUsers.php`.

```php
#[EntityReferenceSelection(
  id = "default:reference_blocked_users",
  label = "Reference Blocked Users",
  entity_types = {"user"},
  group = "default",
  weight = 10,
)]
class ReferenceAllUsers extends UserSelection { … }
```

## Why it applies automatically

Drupal's `SelectionPluginManager::getPluginId($target_type, 'default')` collects every selection
plugin registered for the target entity type in the requested group and returns the
**highest-`weight`** one. Core's `UserSelection` is `default:user` with weight 0; this plugin is
weight 10 in the same `default` group for `user`, so it becomes the effective handler for **all**
user reference fields (including `node.uid` "Authored by") **without any field configuration**.
Nothing else in the module registers it — the weight alone wins the election.

## What it changes

Only `buildEntityQuery()` is overridden. It delegates to the parent (unchanged, active-users-only
behaviour) unless the current user lacks `administer users` yet holds `reference blocked users`, in
which case it calls `buildEntityQueryForAllUsers()`:

```php
$query = $this->entityTypeManager->getStorage('user')->getQuery();
$query->accessCheck();                               // still access-checked
if (!$configuration['include_anonymous']) {
  $query->condition('uid', 0, '<>');                 // drop anonymous if configured
}
if (isset($match)) {
  $query->condition('name', $match, $match_operator);
}
if (!empty($configuration['filter']['role'])) {
  $query->condition('roles', $configuration['filter']['role'], 'IN');
}
$query->condition('status', 0, '>=');                // KEY: includes blocked (0) and active (1)
```

The one substantive difference from core is the `status` condition: core adds `status = 1`
(active only) for non-admins, whereas this returns `status >= 0` (active **and** blocked).

## Overriding / interacting

- To change behaviour, subclass `ReferenceAllUsers` (or core `UserSelection`) and register your own
  `default:*` plugin for `user` with a higher `weight`.
- A field can still opt out by explicitly setting its handler to `default:user` in
  `field.field.*.handler` (Views/programmatic), which the weight-based default does not override
  when a handler is set explicitly.
- The `filter[role]` and `include_anonymous` settings come from the field's normal reference
  handler settings and are respected here.
