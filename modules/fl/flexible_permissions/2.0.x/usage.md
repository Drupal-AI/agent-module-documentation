Flexible permissions is a developer API that gathers, calculates and caches permissions from any number of sources, letting a module turn its access layer into Policy Based Access Control (PBAC). It is a foundation library with no UI, meant to be implemented by access-defining modules (Group, and potentially Domain, Commerce Stores, etc.).

---

Instead of Drupal's single flat permission set, Flexible permissions lets implementing modules register **permission calculators** that each contribute permissions for an account within a named **scope** (e.g. Group's `group_outsider`, `group_insider`, `group_individual`). A `ChainPermissionCalculator` service (`flexible_permissions.chain_calculator`) collects every calculator (tagged `flexible_permission_calculator`, or in 2.0.x provided as a core Access Policy tagged `access_policy` via the bundled `AccessPolicy` bridge), runs them in two passes — a build pass where each calculator adds a `CalculatedPermissionsItem`, then an alter pass — and merges the results into an immutable `CalculatedPermissions` value object. Permissions can be conditional (e.g. only during office hours) because everything is cached with core's **VariationCache**: the cache varies by the persistent cache contexts each calculator declares, so a user gets a different permission set as those contexts change. Each `CalculatedPermissionsItem` holds a scope, an identifier within that scope, a list of permission strings and an `isAdmin` flag (admin grants everything in its scope). A `PermissionChecker` service (`flexible_permissions.checker`) answers the top-level question `hasPermissionInScope($permission, $scope, $identifier, $account)`. In 2.0.x the module bridges to Drupal core's Access Policy API, exposing FP calculators to core and converting between FP and core value objects via `toCore()` / `fromCore()`. The Group module has relied on this module since its 2.0.0 release.

---

- Turn a module's access control into Policy Based Access Control (PBAC) driven by pluggable calculators.
- Gather permissions for an account from many independent sources and merge them into one result.
- Define permissions per **scope** so access is checked in the right context (membership, domain, store, etc.).
- Grant time-based or conditional permissions (e.g. editors may edit only during office hours) that the cache respects.
- Add a permission calculator by tagging a service `flexible_permission_calculator` (legacy) or providing a core Access Policy (`access_policy`, 2.0.x).
- Contribute a `CalculatedPermissionsItem` (scope, identifier, permissions, isAdmin) from a calculator's build pass.
- Grant blanket admin rights within a scope via the `isAdmin` flag instead of listing every permission.
- Alter the fully built permission set in an alter pass (`PermissionCalculatorAlterInterfaceV2::alterPermissions()`).
- Check a single permission programmatically with `PermissionChecker::hasPermissionInScope()`.
- Look up a calculated item for a scope + identifier with `CalculatedPermissions::getItem()`.
- Enumerate all scopes present in a result via `getScopes()`, or all items via `getItems()` / `getItemsByScope()`.
- Cache expensive permission calculations persistently and in memory using core's VariationCache.
- Vary cached permissions by declaring persistent cache contexts in `getPersistentCacheContexts()`.
- Flush all calculated permissions site-wide by invalidating the `flexible_permissions` cache tag.
- Build the Group module's `group_outsider`, `group_insider` and `group_individual` permission scopes.
- Let a Domain-style module define permissions specific to particular domains.
- Let a Commerce-style module define per-store permissions.
- Chain calculators together (a chain can itself contain another chain calculator).
- Bridge FP permissions to Drupal core's Access Policy API and back with `toCore()` / `fromCore()`.
- Reuse core's account switcher so permissions can be calculated for an account other than the current user.
- Prevent privilege escalation by declaring all varying cache contexts up front in `getPersistentCacheContexts()`.
- Base a custom calculator on `PermissionCalculatorBase` to inherit sensible cache-context defaults.
- Validate that a calculator only returns items for the scope it was asked about (scope exceptions are thrown otherwise).
- Extend the access system without touching Drupal core's flat `user.permissions` model.
- Provide the calculated-permission substrate that the Group module builds its entire access layer on.
