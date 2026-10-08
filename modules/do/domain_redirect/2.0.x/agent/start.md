<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain Redirect (domain_redirect) — agent index

Makes the **Redirect** module domain-aware. The same source path can redirect to a
different destination per **Domain** (drupal/domain). Package `Domain`. Core
`^10.2 || ^11`. License GPL-2.0-or-later. Version 2.0.0.

**Depends on** `domain:domain` (^3) and `redirect:redirect` (^1). No PHP libs, no
sub-modules, no permissions, no Drush, no routes, no settings page, **no config
schema of its own**. `require-dev` pulls `drupal/domain_path` for the optional
alias-inheritance integration.

- **Field, forms, install schema changes & the redirect admin view** →
  [config/domain-scoping.md](config/domain-scoping.md)
- **Domain-aware matching (the repository decorator), the uniqueness constraint,
  and Domain Path auto-redirect inheritance** → [api/matching.md](api/matching.md)

## What it actually is (from source)

- **No settings.** Enabling the module is all the configuration there is. Redirect
  destinations are ordinary admin-configured `redirect` entities — never taken from
  request input.
- **`domain_id` base field** added to the `redirect` entity via
  `hook_entity_base_field_info()` (`DomainRedirectHooks::entityBaseFieldInfo`,
  `src/Hook/DomainRedirectHooks.php`): an `entity_reference` to the `domain` entity
  type; **NULL = global (all domains)**.
- **Service decorator** `RedirectRepositoryDecorator` (`src/RedirectRepositoryDecorator.php`,
  `decorates: redirect.repository` in `domain_redirect.services.yml`). Its
  `findMatchingRedirect()` filters candidate redirects by the active domain from
  `Drupal\domain\DomainNegotiationContext` and makes **domain-specific redirects
  win over global** ones. There is **no event subscriber of its own** — the
  Redirect module's request subscriber calls this decorated repository.
- **Uniqueness constraint swap:** `hook_entity_type_alter` replaces the Redirect
  `RedirectUniqueHash` constraint with `DomainAwareUniqueHash`
  (`src/Plugin/Validation/Constraint/DomainAwareUniqueHash.php` +
  `DomainAwareUniqueHashValidator.php`) so the same hash is allowed on different
  `domain_id` values.
- **Install/uninstall** (`domain_redirect.install`) drops the `hash` unique key,
  adds a composite `(hash, domain_id)` index (`hash_domain`), and adds/removes the
  Domain column + exposed filter on `views.view.redirect`. Uninstall reverses all of it.
- **Domain Path integration:** `path_alias_presave` + `redirect_presave` hooks tag
  an auto-created redirect with the domain of a renamed domain-specific alias.
- Hooks are OOP (`#[Hook(...)]` on `DomainRedirectHooks`, service-registered);
  `domain_redirect.module` keeps `#[LegacyHook]` shims that forward to the class.
