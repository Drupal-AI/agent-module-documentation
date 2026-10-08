<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
## What it does

- Provides per-domain user roles on top of Domain Access, so a user can hold different roles on different domains of the site.
- Overrides core cookie authentication to translate domain-prefixed role machine names into their base role names for the currently negotiated domain.
- Adds Views field and filter plugins for working with domain roles.

---

## Install & configure

- Enable the module (requires `domain` and `domain_config`).
- Configure domain roles at `/admin/people/domain_role` (route `domain_role.domain_role_config_form`, permission `administer domains`).
- Assign the generated domain-specific roles to users; the module maps them to effective roles at request time.

---

## Usage & behaviour

- The `DomainCookie` authentication provider (tagged `authentication_provider`, priority 100, global) subclasses core `Cookie` and rewrites the session user's roles.
- On session load it negotiates the active domain, then keeps global (non-domain) roles and maps `"{domain}_{role}"` roles down to `{role}` only when the prefix matches the active domain.
- Role lookups use parameterized SQL against `users_field_data` and `user__roles` (no injection surface).
- Inactive users (`status != 1`) resolve to an anonymous session, matching core behaviour.
- `domain_role_ids()` (in the `.module`) enumerates which base roles are treated as domain roles.
- The admin config form is gated by `administer domains`, the standard Domain suite admin permission.
- Because mapping happens at authentication time, a user's effective roles change automatically as they move between domains.
- Domain-prefixed roles that do not match the active domain are dropped, so cross-domain role leakage is prevented.
- Global roles (not registered as domain roles) always apply on every domain.
- Views integration exposes a Domain Roles field and filter for building per-domain people listings.
- Use it for franchise/affiliate sites where an "editor" on brand A must not be an editor on brand B.
- The provider is `global: TRUE`, so it participates in all requests; verify it composes with any other custom auth providers.
- No routes expose user data beyond the admin form; enforcement is at the auth layer.
- Config is deployable via CMI and `domain_config` for per-domain overrides.
- Clear caches after adding domains or roles so the mapping table is rebuilt.
- Review role definitions after upgrades, since the naming convention `{domain}_{role}` is load-bearing.
