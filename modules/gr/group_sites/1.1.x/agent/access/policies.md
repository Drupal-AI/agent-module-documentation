<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Group Sites — access policies & the negotiator

Group Sites plugs into **Group's Flexible Permissions** system. It does not define a Drupal plugin
type; it uses tagged services collected into a service locator.

## The calculator: `GroupSitesAccessPolicy`
`src/Access/GroupSitesAccessPolicy.php`, service `group_sites.access_policy`, tagged
`flexible_permission_calculator` priority `-500`. Implements `PermissionCalculatorInterface` +
`PermissionCalculatorAlterInterfaceV2`.
- `calculatePermissions()` only adds cache context `user.in_group_sites_admin_mode`.
- `getPersistentCacheContexts()` returns `['user.in_group_sites_admin_mode']` for the individual /
  outsider / insider scopes (Group's `PermissionScopeInterface`), `[]` otherwise. Other cache
  contexts are added later by the context, enabling a cache redirect.
- `alterPermissions()`:
  1. returns early for unsupported scopes;
  2. returns early if `group_sites.admin_mode` `isActive()` (the bypass);
  3. asks `GroupSitesNegotiator::getActiveGroup($cacheable_metadata)` — if a Group is returned it
     runs the configured **site** policy `alterPermissions($group, $account, $scope, $perms)`,
     otherwise the configured **no-site** policy `alterPermissions($account, $scope, $perms)`;
  4. folds the negotiator's cacheable metadata into the calculated permissions.
- Policy services are resolved from a **service locator** (constructor arg `$locator`) built by
  `GroupSitesServiceProvider::alter()`, which references every `group_sites_site_access_policy` and
  `group_sites_no_site_access_policy` tagged service. Resolving a bad ID throws
  `GroupSitesAccessPolicyException`.
- The constructor keeps a BC shim: passing a `ContextRepositoryInterface` as `$negotiator` triggers
  a deprecation and swaps in `group_sites.negotiator`.

## The negotiator: `GroupSitesNegotiator`
`src/GroupSitesNegotiator.php` (`final`, `@internal`), service `group_sites.negotiator`, args
`@config.factory`, `@context.repository`. `getActiveGroup()` reads config `context_provider`, calls
`ContextRepository::getRuntimeContexts([$context_id])`, returns the context value if it is a
`GroupInterface` (else throws `\InvalidArgumentException`), or NULL if no context / no value. Adds
cache tag `config:group_sites.settings` and the context's cacheable dependency. **The module never
inspects the Host header itself** — mapping a request to a Group is entirely the context provider's
responsibility.

## Shipped "site" policy (a Group was found)
`SingleSiteAccessPolicy` (`GroupSitesSiteAccessPolicyInterface`), service
`group_sites.site_access_policy.single`, tag `group_sites_site_access_policy` priority `10`.
Label "Single Group remains active". In `alterPermissions()`:
- For the **individual** scope it keeps only the active Group's item. It adds cache context
  `user.is_group_member:<gid>`, then temporarily sets `adminMode->setAdminModeOverride(TRUE)` so it
  can recompute the account's **insider** (if a member) or **outsider** bundle permissions via
  `flexible_permissions.chain_calculator`, immediately setting the override back to `FALSE`. The
  bundle item and any existing individual item are merged into one `CalculatedPermissionsItem` for
  the active Group.
- For every scope it then calls `removeItemsByScope($scope)` and re-adds only the merged item — so
  all other Groups (even of other types) are stripped of permissions.

## Shipped "no-site" policies (no Group found)
Both implement `GroupSitesNoSiteAccessPolicyInterface`, tag `group_sites_no_site_access_policy`:
- `DenyAllNoSiteAccessPolicy` — service `…deny_all`, priority `10`, label "Deny all Group access".
  `alterPermissions()` calls `$calculated_permissions->removeItems()` — the safe default.
- `DoNothingNoSiteAccessPolicy` — service `…do_nothing`, priority `5`, label "Do nothing". Empty
  `alterPermissions()`; the site behaves as if the module were not installed.

Priority only orders the radios on the settings form (`GroupSitesAccessPolicyRepository`
`getSiteAccessPolicies()` / `getNoSiteAccessPolicies()`, populated by the `service_collector` tags
in `group_sites.services.yml`).

## Writing your own policy
1. Create a service implementing `GroupSitesNoSiteAccessPolicyInterface` (no-Group case) or
   `GroupSitesSiteAccessPolicyInterface` (Group case) — each requires `getLabel()`,
   `getDescription()`, and `alterPermissions(...)`.
2. Tag it `group_sites_no_site_access_policy` or `group_sites_site_access_policy` (optional
   `priority`).
3. Select it on `/admin/group/sites/settings`. Study the shipped policies and the Flexible
   Permissions module for how to manipulate `RefinableCalculatedPermissionsInterface` items.
