# Extend Entity Access Password

The module has no plugin manager; extension points are **tagged service collections** and an **event**.
Add your service to `*.services.yml` with `autoconfigure: true` (or the explicit tag).

## Custom password validator

Tag `entity_access_password_password_validator`. Implement `PasswordValidatorInterface::validatePassword`.
Higher `priority` runs first; the default `PasswordValidator` has priority 100. Use for e.g. per-role or
one-time passwords. On success call the injected `AccessStorageInterface` to record access.

## Custom access storage backend

Tag `entity_access_password_access_storage`. Implement `AccessStorageInterface` (write:
`storeEntityAccess`, `storeEntityBundleAccess`, `storeGlobalAccess`). `AccessStorageManager` calls **every**
tagged storage when access is granted. Ship your read side too (see below). The bundled submodules are the
canonical examples: session backend (also implements the checker) and user-data backend.

## Custom access checker

Tag `entity_access_password_access_checker`. Implement `AccessCheckerInterface`
(`hasUserAccessToEntity/Bundle`, `hasUserGlobalAccess`). `AccessCheckerManager` returns TRUE if **any**
tagged checker returns TRUE. Built-in `BypassPermissionAccessChecker` (priority 200) short-circuits for
holders of `bypass_password_protection`. Use this to add e.g. an IP-allowlist bypass.

A backend that both stores and answers (like the session backend) implements both interfaces and carries
both tags.

## FileUsageEntityListEvent

`Drupal\entity_access_password\Event\FileUsageEntityListEvent` fires during `hook_file_download`. Subscribe
to add/remove entities considered "users" of a private file (the bundled
`WebformSubmissionFileUsageSubscriber` maps webform submission files to their host entity). `getEntities()`
/ `setEntities()` mutate the list that decides whether the download is gated.
