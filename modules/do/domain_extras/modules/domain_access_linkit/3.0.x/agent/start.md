# Linkit for Domain Access (domain_access_linkit) 3.0.x

Provides a Linkit node autocomplete matcher that lets permitted editors link to content on any of their assigned domains, not just the active domain.

## Facts

- **Dependencies:** `domain_access:domain_access`, `linkit:linkit` (info.yml).
- **Package:** Domain. `core_version_requirement: ^10.2 || ^11`.
- **Routes:** none. No `configure` route.
- **Services:** `Drupal\domain_access_linkit\Hook\DomainAccessLinkitHooks` (autowired, `domain_access_linkit.services.yml`) — carries the hook implementation.
- **Permissions** (`domain_access_linkit.permissions.yml`): `link to content on assigned domains` — "Allow linking to content on all assigned domains".
- **Plugins (implements, does not define):** Linkit Matcher `AssignedDomainsNodeMatcher`, id `node_assigned_domains`, label "Assigned Domains Content", `target_entity = node`, extends `Drupal\linkit\Plugin\Linkit\Matcher\NodeMatcher` (`src/Plugin/Linkit/Matcher/AssignedDomainsNodeMatcher.php`).
- **Hooks:** `hook_node_grants_alter()` in `DomainAccessLinkitHooks::nodeGrantsAlter()` (`src/Hook/DomainAccessLinkitHooks.php`); `#[LegacyHook]` procedural shim `domain_access_linkit_node_grants_alter()` in `domain_access_linkit.module`.
- **Config / schema:** none.

## How it works

`AssignedDomainsNodeMatcher::execute($string)` checks `link to content on assigned domains`. If held, it stores the current user's assigned-domain grant ids (`DomainAccessManager::getAccessValues()` on the loaded user entity) in a `drupal_static` keyed by `AssignedDomainsNodeMatcher::TEMP_ASSIGNED_DOMAINS_NODE_GRANTS`, calls `parent::execute()` (the normal Linkit node autocomplete query), then resets the static in a `finally`. `nodeGrantsAlter()` reads that static and merges the temporary grants into `$grants` per realm, so the autocomplete query sees the user's assigned domains as granted realms. Users without the permission get plain `NodeMatcher` behavior.

## Setup

1. Enable the module (`drush en domain_access_linkit -y`); requires `domain_access` and `linkit`.
2. Grant `link to content on assigned domains` to the roles that should link across their assigned domains.
3. Edit a Linkit profile (`/admin/config/content/linkit`) and add the **Assigned Domains Content** matcher (`node_assigned_domains`); configure its node settings as with the standard node matcher.
4. Use that Linkit profile in the relevant text-format link dialog.

## Docs

- Only `start.md`; the module is a single matcher plugin plus one hook.
