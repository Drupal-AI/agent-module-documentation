Adds a Linkit autocomplete matcher that lets editors link to node content assigned to any of the domains they are assigned to, not just the currently active domain.

---

Linkit for Domain Access ships one Linkit matcher plugin, `AssignedDomainsNodeMatcher` (id `node_assigned_domains`, `target_entity = node`), which extends Linkit's core `NodeMatcher`. When a Linkit profile uses this matcher, its `execute()` (`src/Plugin/Linkit/Matcher/AssignedDomainsNodeMatcher.php`) checks whether the current user holds the `link to content on assigned domains` permission; if so it primes a static cache with the domain grant ids returned by `DomainAccessManager::getAccessValues()` for the current user, runs the normal node autocomplete query, then clears the static. A `hook_node_grants_alter()` implementation in `Drupal\domain_access_linkit\Hook\DomainAccessLinkitHooks` (registered as a service in `domain_access_linkit.services.yml`, with a `#[LegacyHook]` shim in the `.module`) reads that static cache and merges the temporary grants into the node access grants for the matcher's query, so the autocomplete can surface content published to the user's assigned domains regardless of which domain is currently active. The module defines one permission in `domain_access_linkit.permissions.yml` and provides no routes, config, or forms of its own. Requires `domain_access` and `linkit`.

---

- Let editors link to nodes on all of their assigned domains, not just the active one.
- Add an "Assigned Domains Content" matcher (`node_assigned_domains`) to a Linkit profile.
- Autocomplete node titles across a user's assigned affiliate domains in a CKEditor link dialog.
- Grant the `link to content on assigned domains` permission to roles that need cross-domain linking.
- Restrict cross-domain link autocomplete to only the domains a user is actually assigned to.
- Keep standard active-domain behavior for users without the permission.
- Reuse Linkit's existing node matcher configuration (bundles, substitution, result limits).
- Wire the matcher into WYSIWYG link insertion for multi-domain editorial workflows.
- Build affiliate-site content that references peer-domain nodes without switching domains.
- Fall back to Linkit's core `NodeMatcher` behavior when the permission is absent.
- Merge per-user domain grants into node autocomplete queries via `hook_node_grants_alter()`.
- Resolve a user's assigned domains through `DomainAccessManager::getAccessValues()`.
- Pair with Domain Access node assignment fields to scope autocomplete results by domain.
- Configure matcher behavior entirely through the standard Linkit profile UI.
- Enable cross-domain content discovery for editors managing several affiliate sites.
