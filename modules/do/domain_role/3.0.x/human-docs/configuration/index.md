# Configuration

Setting up Domain Role means defining which roles are domain-specific, then
assigning the resulting per-domain roles to the right users.

## Define domain roles

1. Log in as a user with the **Administer domains** permission.
2. Go to **People → Domain Role**, or navigate directly to
   `/admin/people/domain_role`.
3. Use the form to configure which roles should be treated as **domain roles**.
   For each domain, Domain Role manages a domain-specific variant of those roles
   (following the `{domain}_{role}` naming convention internally).
4. **Save**, then clear caches so the mapping is rebuilt.

Roles you do **not** register as domain roles remain **global** — they apply on
every domain, for every user who holds them.

## Assign roles to users

On the ordinary **user edit** screen (**People → *(user)* → Edit**), assign the
generated domain-specific roles to each account. Remember that an account needs the
appropriate role on **each** domain where it should have access — there is no
"same role everywhere" shortcut, because that is exactly what this module is
designed to avoid.

At request time the module negotiates the active domain and maps the account's
matching `{domain}_{role}` roles down to their base role (e.g. `editor`) for that
domain, keeps any global roles, and drops roles belonging to other domains. So an
account's effective permissions change automatically as it moves between domains.

## Building per-domain people listings

Domain Role adds Views integration: a **Domain Roles** field and a **Domain Roles**
filter. Use these in a View to build people listings scoped to a particular
domain — for example "all editors on brand A".

## Good practice

- **Permissions are still global.** This module partitions roles, not permissions.
  Assign permissions to the base roles as usual; the domain scoping controls *who
  holds which role where*.
- **Keep it to lower-level roles.** Because admin-level access can include ways to
  change configuration insecurely, the maintainers recommend using domain roles
  for staff-level roles rather than as a containment layer for full administrators.
- **Clear caches after structural changes.** Adding domains or roles requires a
  cache rebuild for the mapping to take effect, and the `{domain}_{role}` naming
  convention is load-bearing — review role definitions after upgrades.
- Configuration is deployable via Drupal's config management and `domain_config`
  per-domain overrides.
