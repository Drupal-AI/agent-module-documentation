# Entity Access Password — services API

Autowire by interface. Core services (all in `Drupal\entity_access_password\Service`):

| Interface | Purpose |
|---|---|
| `PasswordValidatorInterface` | `validatePassword(string $password, EntityAccessPasswordItem $fieldItem): bool` — checks the password against enabled scopes (entity/bundle/global) with core `PasswordInterface::check`; on success calls the access storage to record access. |
| `PasswordAccessManagerInterface` | The read side. `hasUserAccessToEntity(EntityInterface): bool`, `isEntityViewModeProtected(string $view_mode, EntityInterface): bool`, `isEntityLabelProtected(EntityInterface): bool`. Const `PROTECTED_VIEW_MODE = 'password_protected'`. |
| `AccessStorageInterface` | Write side: `storeEntityAccess()`, `storeEntityBundleAccess()`, `storeGlobalAccess()`. The manager fans out to every tagged storage (submodules). |
| `AccessCheckerInterface` | Read side aggregate: `hasUserAccessToEntity/Bundle`, `hasUserGlobalAccess`. Backends + the built-in `BypassPermissionAccessChecker` (perm `bypass_password_protection`, priority 200). |
| `PasswordFormBuilderInterface` | Lazy builder for the password form render array (`#theme 'entity_access_password_form'`). |
| `EntityTypePasswordBundleInfoInterface` | Lists which entity-type/bundle combos have a password field. |
| `RouteParserInterface` | Finds the entity in the current route (used for label masking). |

The password **form** is `Drupal\entity_access_password\Form\PasswordForm` (base form id
`entity_access_password_password`). Validation mirrors core `UserLoginForm`: `validatePassword` checks
`user.flood` IP/user limits then runs the validator; `validateFinal` registers flood on failure and clears
it on success. Access is stored inside the validator (it knows the scope), not the form submit.

Example — check access programmatically:
```php
$mgr = \Drupal::service(\Drupal\entity_access_password\Service\PasswordAccessManagerInterface::class);
if (!$mgr->hasUserAccessToEntity($node)) {
  // user has not unlocked $node
}
```

## Cache context

`entity_access_password_entity_is_protected` (class `Cache\Context\EntityIsProtectedCacheContext`) is a
**calculated** context. Parameter form: `<entity_type>||<id>` (label) or `<entity_type>||<id>||<view_mode>`
(view mode). It returns `'1'` when the given entity/view-mode is protected AND the current user lacks
access, else `'0'`, and adds the entity as a cache dependency. Add it when you render anything whose output
depends on whether the current user has unlocked an entity.

## File access

`hook_file_download` (`src/Hook/FileDownload.php`) denies (`-1`) private-scheme file downloads whose
file-usage entities are all protected-and-not-unlocked for the current user; returns `NULL` (defer) if the
user has access to at least one using entity. The entity list is alterable via `FileUsageEntityListEvent`.
